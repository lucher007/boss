$(function () {
  initLeftMenu();
});

function initLeftMenu() {
  var doc = document.getElementById('header');
  if (0 < doc.children.length) {
    var node = doc.children[0];
    var id = node.id;
    loadTopology(id);
  }
}

/**
 * 加载业务信息管理列表
 */
function loadTopology(id) {
  var setting = {
    view: {
      selectedMulti: false,
      showTitle: false
    },
    async: {
      enable: true,
      autoParam: ['id', 'type'],
      url: 'treeMenu!getNextMenu.shtml'
    },
    data: {
      simpleData: {
        enable: true
      },
      keep: {
        parent: true
      }
    },
    callback: {
      onClick: treeOnClick
    }
  };
  if (id == '4') { // 业务信息管理中的节点右边添加菜单
    setting.view.addHoverDom = addHoverDom;
    setting.view.removeHoverDom = removeHoverDom;
  }
  var data = {
    menuid: id,
    t: new Date().getTime()
  };
  var url = 'treeMenu!getTreeMenu.shtml';
  $.getJSON(url, data, function (jsonMsg) {
    $.fn.zTree.init($('#treeDemo'), setting, jsonMsg);
    initSelectedNode();
  });
}

function treeOnClick(event, treeId, treeNode) {
  if (treeNode.level == 0) {
    if (treeNode.type != 0 || $('#usertype').val() != '1') {
      initSelectedNode();
    }
    return;
  }
  if (undefined != treeNode.path) { // 其他管理
    $('#main').attr('src', '' + treeNode.path + '?netid=' + treeNode.pId);
  } else { // 业务信息管理
    selectNode($.fn.zTree.getZTreeObj(treeId), treeNode);
  }
}

function selectNode(treeObj, treeNode) {
  treeObj.selectNode(treeNode);
  if (treeNode.level == 0) {
    initSelectedNode();
    return;
  }
  var type = treeNode.type,
      id = treeNode.id.toString().substr(3),
      url = 'Init.shtml?id=' + id;
  switch (type) {
    case 1:
      url = 'network!updateNetwork' + url;
      break;
    case 2:
      url = 'transportstream!updateTransportstream' + url;
      break;
    case 3:
      url = 'bouquet!updateBouquet' + url;
      break;
    case 4:
      if (treeNode.getParentNode().type == 3) {
        url = 'service!serviceInfo.shtml?id=' + id;
      } else {
        url = 'service!updateService' + url;
      }
      break;
    case 5:
      url = 'ca!updateCa' + url;
      break;
    default :
      url = '';
      break;
  }
  $('#main').attr('src', url);
}

function addHoverDom(treeId, treeNode) {
  var btn = $('#option_' + treeNode.tId);
  if (btn.length > 0) {
    return;
  }
  var nodeSpan = $('#' + treeNode.tId + '_span'),
      addStr = 'id="option_' + treeNode.tId + '" onfocus="this.blur();"></span>',
      nodeType = treeNode.type,
      flag = (nodeType == 4 && treeNode.getParentNode().type == 3) // 信束下的业务
          || nodeType == 5; // 或CA
  if (treeNode.level == 0) {// 根节点
    if ($('#usertype').val() == '1') {
      addStr = '<span class="button add" title="添加网络"' + addStr;
    } else {
      return;
    }
  } else if (flag) {
    addStr = '<span class="button remove" title="删除"' + addStr;
  } else {
    addStr = '<span class="button option" title="选项"' + addStr;
  }
  nodeSpan.after(addStr);
  btn = $('#option_' + treeNode.tId);
  if (btn) {
    btn.bind('click', function (e) {
      if (treeNode.level == 0) {
        $('#main').attr('src', 'network!addNetworkInit.shtml');
      } else if (flag) {
        removeButton(treeNode);
      } else {
        showMenu(e, nodeType);
      }
    });
  }
}

function removeButton(treeNode) {
  var nodeType = treeNode.type,
      parentNode = treeNode.getParentNode(),
      confirmStr = '确认删除"' + treeNode.name + '"吗？',
      params = {id: treeNode.id.toString().substr(3)},
      url;
  if (nodeType == 4) { // 信束下业务
    confirmStr = '从"' + parentNode.name + '"中移除"' + treeNode.name + '"吗？';
    url = 'serviceJSON!deleteServiceFromBouquet.shtml';
    params.bouquetid = parentNode.id.toString().substr(3);
  } else if (nodeType == 5) { // CA
    url = 'caJSON!deleteCa.shtml';
  }
  $.dialog.confirm(confirmStr, function () {
    $.get(url, params, function (data) {
      $.dialog.tips(data[0]['info'], 1, 'alert.gif', function () {
        if (data[0]['deleteflag']) {
          var treeObj = $.fn.zTree.getZTreeObj('treeDemo');
          treeObj.removeNode(treeNode);
          selectNode(treeObj, parentNode);
        }
      });
    });
  }, function () {
  });
}

function removeHoverDom(treeId, treeNode) {
  $('#option_' + treeNode.tId).unbind().remove();
}

function initSelectedNode() {
  var treeObj = $.fn.zTree.getZTreeObj('treeDemo');
  var nodes = treeObj.getNodes();
  if (null != nodes && nodes.length > 0) {
    if (undefined != nodes[0].children && null != nodes[0].children && 0 < nodes[0].children.length) {
      var node = nodes[0].children[0];
      treeObj.selectNode(node);
      if (undefined != node.path && undefined != node.pId) {
        $('#main').attr('src', '' + node.path + '?netid=' + node.pId);
      } else { // 业务信息管理下的第一个网络
        var netid = node.id.toString().substr(3);
        $('#main').attr('src', 'network!updateNetworkInit.shtml?id=' + netid);
      }
    } else {
      $('#main').attr('src', '');
      treeObj.selectNode(nodes[0]);
    }
  }
}

function showMenu(event, nodeType) {
  var menu;
  if (nodeType == 1) {
    menu = $('#netMenu');
  } else {
    var text;
    if (nodeType == 2) { // TS
      text = '添加业务';
    } else if (nodeType == 3) { // 信束
      text = '添加业务到信束';
    } else if (nodeType == 4) { // 业务
      text = '事件管理';
    }
    menu = $('#menu');
    menu.menu('setText', {
      target: $('#add'),
      text: text
    });
  }
  menu.menu('show', {
    left: event.clientX,
    top: event.clientY
  });
}

function menuClick(item) {
  var treeObj = $.fn.zTree.getZTreeObj('treeDemo'),
      node = treeObj.getSelectedNodes()[0];
  if (node == undefined || node == null) {
    $.dialog.tips('请先选择节点', 1, 'alert.gif');
    return;
  }
  var nodeType = node.type,
      parentNode = node.getParentNode(),
      id = node.id.toString().substr(3),
      main = $('#main'),
      url = '';
  if (nodeType == 1) { // 网络
    switch (item.text) {
      case 'TS':
        url = 'transportstream!addTransportstreamInit.shtml?netid=' + id;
        break;
      case '信束':
        url = 'bouquet!addBouquetInit.shtml?netid=' + id;
        break;
      case 'CA':
        url = 'ca!addCaInit.shtml?netid=' + id;
        break;
      case '删除':
        url = 'networkJSON!deleteNetwork.shtml';
        break;
      default :
        break;
    }
  } else if (nodeType == 2) { // TS
    if (item.text == '添加业务') {
      url = 'service!addServiceInit.shtml?netid=' + parentNode.id.toString().substr(3) + '&tsid=' + id;
    } else if (item.text == '删除') {
      url = 'transportstreamJSON!deleteTransportstream.shtml';
    }
  } else if (nodeType == 3) { // 信束
    if (item.text == '添加业务到信束') {
      url = 'service!addServiceToBouquetInit.shtml?bouquetid=' + id;
    } else if (item.text == '删除') {
      url = 'serviceBouquetJSON!deleteBouquet.shtml';
    }
  } else if (nodeType == 4) { // 业务
    if (item.text == '事件管理') {
      url = 'event!findByList.shtml?serviceid=' + id + '&netid=' + parentNode.getParentNode().id.toString().substr(3);
    } else if (item.text == '删除') {
      url = 'serviceJSON!deleteService.shtml';
    }
  }
  if (url == '') {
    return;
  }
  if (item.text == '删除') {
    $.dialog.confirm('确定删除"' + node.name + '"？', function () {
      $.get(url, {id: id}, function (data) {
        $.dialog.tips(data[0]['info'], 1, 'alert.gif');
        if (data[0]['deleteflag']) {
          if (nodeType == 4) {
            var nodes = treeObj.getNodesByParam('id', node.id);
            for (var i in nodes) {
              treeObj.removeNode(nodes[i]);
            }
          } else if (nodeType == 1) {
            treeObj.removeNode(node);
          } else {
            treeObj.reAsyncChildNodes(parentNode, "refresh");
          }
          selectNode(treeObj, parentNode);
        }
      });
    }, function () {
    });
  } else {
    main.attr('src', url);
  }
}

/**
 *退出系统
 */
function logout() {
  $.dialog.confirm('确定退出系统？', function () {
    window.location.href = '/login.jsp';
  }, function () {
  });
}

var userInfoDialog;
function userInfo() {
  userInfoDialog = $.dialog({
    title: "个人资料",
    lock: true,
    width: 670,
    height: 300,
    drag: false,
    resize: false,
    max: false,
    min: false,
    content: "url:user!userInfoInit.shtml?t=" + new Date().getTime()
  });
}

var helpInfoDialog;
function helpInfo() {
  helpInfoDialog = $.dialog({
    title: "系统帮助",
    lock: true,
    width: 670,
    height: 300,
    drag: false,
    resize: false,
    max: false,
    min: false,
    content: "url:user!helpInfoInit.shtml?t=" + new Date().getTime()
  });
}

function addNode(newNode) {
  if (newNode) {
    var treeObj = $.fn.zTree.getZTreeObj('treeDemo'),
        pNode = treeObj.getNodeByParam('id', newNode.pId);
    if (pNode.level == 0) {
      treeObj.addNodes(pNode, newNode);
    } else if (pNode.zAsync) {
      treeObj.reAsyncChildNodes(pNode, 'refresh');
    }
  }
}

function updateNode(node) {
  if (node) {
    var treeObj = $.fn.zTree.getZTreeObj('treeDemo'),
        treeNode = treeObj.getNodeByParam('id', node.id),
        nameNotEqual = treeNode.name != node.name,
        pidNotEqual = treeNode.pId != node.pId;
    if (nameNotEqual || pidNotEqual) {
      treeNode.name = node.name;
      if (pidNotEqual) {
        treeNode.pId = node.pId;
        var parentNode = treeObj.getNodeByParam('id', treeNode.pId);
        if (parentNode.level == 0) {
          treeObj.moveNode(parentNode, treeNode, 'inner');
        } else {
          treeObj.removeNode(treeNode);
          treeObj.reAsyncChildNodes(parentNode, 'refresh');
          return;
        }
      }
      treeObj.updateNode(treeNode);
    }
  }
}

function updateServiceNode(node) {
  var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
      netNode = treeObj.getNodeByParam("id", node.netid),
      tsNode = treeObj.getNodeByParam("id", node.pId, netNode),
      serviceNode = treeObj.getNodeByParam("id", node.id, tsNode),
      bouquetNodes = treeObj.getNodesByParam("type", 3, netNode);

  if (serviceNode.name != node.name) {
    serviceNode.name = node.name;
    treeObj.updateNode(serviceNode);

    for (var i = 0; i < bouquetNodes.length; i++) {
      if (bouquetNodes[i].zAsync) {
        serviceNode = treeObj.getNodeByParam("id", node.id, bouquetNodes[i]);
        if (serviceNode != null) {
          serviceNode.name = node.name;
          treeObj.updateNode(serviceNode);
        }
      }
    }
  }
}

function updateBouquetNode(nodeid) {
  var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
      bouquetNode = treeObj.getNodeByParam("id", nodeid);
  if (bouquetNode.zAsync) {
    treeObj.reAsyncChildNodes(bouquetNode, "refresh");
  }
}

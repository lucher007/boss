function locatePoint(){ 
	var aCtrl = document.getElementById("boxcodes"); 
	var   o=aCtrl.createTextRange();    
 		o.move("character",aCtrl.value.length);    
 		o.select();    		
} 
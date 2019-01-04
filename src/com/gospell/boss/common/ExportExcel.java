package com.gospell.boss.common;

import java.io.OutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Giftcard;
import com.gospell.boss.po.Product;

public class ExportExcel {

	public static String resultSetToExcel(Object obj, String[] columntitle, String reportName, HttpServletResponse response) throws Exception {
		HSSFWorkbook workbook = reportTypeHandler(obj, reportName, columntitle);
		return workbook != null ? downloadExcel(workbook, reportName, response) : "fail";
	}

	// 需要在此方法中根据ReportNmae把传入的OBJECT转化相应的PO对象
	// 比如在CONTROLLER中传入的reportName为StoreReport_Storeid15,以"_"分割后的数组[0]就是StoreReport
	// 则在本方法中OBJECT应该转化为StoreReport对应的BusinessReport对象后再进行填表处理
	// 当需要导出不同的Report时需在本方法中增加IF条件来处理
	public static HSSFWorkbook reportTypeHandler(Object obj, String reportName, String[] columntitle) {
		HSSFWorkbook workbook = new HSSFWorkbook();
		String[] type = reportName.split("_");
		// StoreReport和OperatorReport都属于BusinessReport类且需要的项相同(如不同不能一起处理)，所以放在一起处理
		if (type[0].equals("StoreReport") || type[0].equals("OperatorReport")) {//营业厅报表和操作员报表
			HSSFSheet sheet = workbook.createSheet(type[1]);
			// EXCEL 主SHEET 名称
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = null;
			BusinessReport target = (BusinessReport) obj;
			int nColumn = columntitle.length;
			// 填写表头
			for (int i = 0; i < nColumn; i++) {
				cell = row.createCell((i));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(columntitle[i]);
			}
			int rowIndex = 1;
			// 向EXCEL中逐行填表
			for (BusinessReport businessReport : target.getBusinessReportList()) {
				row = sheet.createRow((short) rowIndex);
				for (int j = 0; j < nColumn; j++) {
					cell = row.createCell(j);
					// 如果可以转化为数字则填入数字，如果不行则填入String方便Excel后续处理数据
					try {
						Double number = Double.parseDouble(businessReport.getExcelMap().get(columntitle[j]));
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cell.setCellValue(number);
					} catch (Exception e) {
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(businessReport.getExcelMap().get(columntitle[j]));
					}
				}
				rowIndex++;
			}
			return workbook;// 返回数据填写完毕的workbook
		} else if (type[0].equals("ProductReport")) { //产品购买统计

			HSSFSheet sheet = workbook.createSheet(type[1]);
			// EXCEL 主SHEET 名称
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = null;
			Product target = (Product) obj;
			int nColumn = columntitle.length;
			// 填写表头
			for (int i = 0; i < nColumn; i++) {
				cell = row.createCell((i));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(columntitle[i]);
			}
			int rowIndex = 1;
			// 向EXCEL中逐行填表
			for (Product product : target.getProductlist()) {
				row = sheet.createRow((short) rowIndex);
				for (int j = 0; j < nColumn; j++) {
					cell = row.createCell(j);
					// 如果可以转化为数字则填入数字，如果不行则填入String方便Excel后续处理数据
					try {
						Double number = Double.parseDouble(product.getBusinessReport().getExcelMap().get(columntitle[j]));
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cell.setCellValue(number);
					} catch (Exception e) {
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(product.getBusinessReport().getExcelMap().get(columntitle[j]));
					}
				}
				rowIndex++;
			}
			return workbook;// 返回数据填写完毕的workbook
		} else if (type[0].equals("GiftcardReport")) { //导出充值卡号
			HSSFSheet sheet = workbook.createSheet(type[1]);
			// EXCEL 主SHEET 名称
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = null;
			Giftcard target = (Giftcard) obj;
			int nColumn = columntitle.length;
			// 填写表头
			for (int i = 0; i < nColumn; i++) {
				cell = row.createCell((i));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(columntitle[i]);
			}
			int rowIndex = 1;
			// 向EXCEL中逐行填表
			for (Giftcard giftcard : target.getGiftcardlist()) {
				row = sheet.createRow((short) rowIndex);
				for (int j = 0; j < nColumn; j++) {
					cell = row.createCell(j);
					// 如果可以转化为数字则填入数字，如果不行则填入String方便Excel后续处理数据
					try {
						if(j==2){
							Double number = Double.parseDouble(giftcard.getExcelMap().get(columntitle[j]));
							cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
							cell.setCellValue(number);
						}else{
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(giftcard.getExcelMap().get(columntitle[j]));
						}
					} catch (Exception e) {
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(giftcard.getExcelMap().get(columntitle[j]));
					}
				}
				rowIndex++;
			}
			return workbook;// 返回数据填写完毕的workbook
		}
		return workbook; // 如果没有对应的IF方法处理OBJECT，则直接返回空的workbook
	}

	public static String downloadExcel(HSSFWorkbook workbook, String reportName, HttpServletResponse response) throws Exception {
		String filename = reportName + ".xls";
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment; filename=" + filename);
		OutputStream ouputStream = response.getOutputStream();
		workbook.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
		return "success";
	}

}

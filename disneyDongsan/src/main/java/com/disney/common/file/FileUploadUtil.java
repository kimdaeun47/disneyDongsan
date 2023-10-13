package com.disney.common.file;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUploadUtil {
	
	/**********************************************************
	 * 파일 업로드할 폴더 생성
	 **********************************************************/
	public static void makeDir(String docRoot) {
		File fileDir =new File(docRoot);
		if(fileDir.exists()) {
			return;
		}
		fileDir.mkdirs();
	}
	
	public static String fileUpload(MultipartFile file, String fileName) throws IOException{
		log.info("fileUpload 호출 성공 ");
		
		String real_name=null;
		// MultipartFile 클래스의 getFile() 메서드로 클라이언트가 업로드한 파일
		String org_name = file.getOriginalFilename();
		log.info("업로드 파일명 :" +org_name);
		
		// 파일명 변경(중복되지 않게)
		if(org_name != null && (!org_name.equals(""))) {
			real_name = fileName +"_"+ System.currentTimeMillis() +"_"+ org_name; // 저장할 파일 이름
			
			String docRoot = "C://dongsanStorage//"+fileName;
			makeDir(docRoot);
			
			File fileAdd = new File(docRoot+"/"+real_name);
			log.info("업로드할 파일(fileAdd) : " + fileAdd);
			
			file.transferTo(fileAdd); // 이 메서드에 의해 저장 경로에 실질적으로 File이 생성됨.
		}
		return real_name; // 서버에 저장된 파일명 반환
	}
	
	//삭제
	public static void fileDelete(String fileName) throws IOException{
		log.info("fileDelete 호출 성공 ");
		boolean result = false;
		String dirName = fileName.substring(0, fileName.indexOf("_"));
		String docRoot = "C:/dongsanStorage/"+dirName;
		File fileDelete = new File(docRoot+"/"+fileName);
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제 여부(true/false) : " + result);
	}

}

package com.disney.client.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.NoticeDao;
import com.disney.vo.NoticeVO;

import lombok.Setter;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Setter(onMethod_ = @Autowired)
	private NoticeDao noticeDao;

	@Override
	public List<NoticeVO> noticeList(NoticeVO vo) {
		List<NoticeVO> list = null;
		list = noticeDao.noticeList(vo);
		return list;
	}

	@Override
	public int noticeListCnt(NoticeVO vo) {
		return noticeDao.noticeListCnt(vo);
	}

	@Override
	public NoticeVO noticeDetail(NoticeVO nvo) {
		//noticeDao.readCtnUpdate(nvo);
		
		NoticeVO detail = noticeDao.noticeDetail(nvo);
		
		if(detail != null) {
			detail.setN_content(detail.getN_content().toString().replace("\n", "<br />"));
		}
		
		return detail;
		
	}

	@Override
	public NoticeVO prevNext(int reviewNum) {
		return noticeDao.prevNext(reviewNum);
	}
	
	//입력
	@Override
	public int noticeInsert(NoticeVO vo) throws Exception {
		return noticeDao.noticeInsert(vo);
	}
	
	//수정
	@Override
	public int noticeUpdate(NoticeVO vo) throws Exception {
		return noticeDao.noticeUpdate(vo);
	}
	
	// 삭제
	@Override
	public int noticeDelete(NoticeVO vo) throws Exception {
		return noticeDao.noticeDelete(vo);
	}

	@Override
	public NoticeVO updateForm(NoticeVO vo) {
		return noticeDao.noticeDetail(vo);
	}

	@Override
	public int adminAllNoticeDelete(NoticeVO vo) {
		int result = 0;
        result = noticeDao.adminAllNoticeDelete(vo);
        return result;
	}

	@Override
	public NoticeVO adminSearchNoticeNo(String noticeId) {
		return noticeDao.adminSearchNoticeNo(noticeId);
	}



//	@Override
//	public String uploadImageAndReturnUrl(MultipartFile file) throws IOException {
//		if (file != null && !file.isEmpty()) {
//            String fileName = StringUtils.cleanPath(file.getOriginalFilename());
//
//            String uploadPath = "C:/uploadStorage/notice/";
//
//            // 업로드 경로에 폴더 생성
//            File uploadDirectory = new File(uploadPath);
//            if (!uploadDirectory.exists()) {
//                uploadDirectory.mkdirs();
//            }
//
//            // 파일 저장 경로 설정
//            String filePath = uploadPath + fileName;
//
//            // 파일을 업로드 경로에 저장
//            file.transferTo(new File(filePath));
//
//            // 업로드된 이미지의 URL 반환
//            String imageUrl = "/uploadStorage/notice/" + fileName;
//
//            return imageUrl;
//        }
//        return null; // 파일이 비어있거나 업로드 실패 시 null 반환
//    }
	



	
}

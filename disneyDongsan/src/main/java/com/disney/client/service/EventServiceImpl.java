package com.disney.client.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.EventDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.EventVO;

import lombok.Setter;

@Service
public class EventServiceImpl implements EventService {

	@Setter(onMethod_ = @Autowired)
	private EventDao eventDao;

	@Override
	public List<EventVO> eventList(EventVO vo) {
		return eventDao.eventList(vo);
	}

	@Override
	public int eventListCnt(EventVO vo) {
		return eventDao.eventListCnt(vo);
	}

	@Override
	public int eventInsert(EventVO vo) throws Exception {
		if (vo.getFile1() != null && !vo.getFile1().isEmpty()) {
            String fileName1 = FileUploadUtil.fileUpload(vo.getFile1(), "event");
            vo.setE_img1(fileName1);
        }
		
		if (vo.getFile2() != null && !vo.getFile2().isEmpty()) {
            String fileName2 = FileUploadUtil.fileUpload(vo.getFile2(), "event");
            vo.setE_img2(fileName2);
        }
		
		if (vo.getFileT() != null && !vo.getFileT().isEmpty()) {
            String fileNameT = FileUploadUtil.fileUpload(vo.getFileT(), "event");
            vo.setE_thum(fileNameT);
        }
		
		return eventDao.eventInsert(vo);
	}

	@Override
	public EventVO eventDetail(EventVO vo) {
		EventVO detail = eventDao.eventDetail(vo);
		if(detail != null) {
			detail.setE_content(detail.getE_content().toString().replace("\n", "<br />"));
		}
		
		return detail;
	}
	
	@Override
	public int eventUpdate(EventVO vo) throws Exception {
		int result = 0;
		
		if (vo.getFileT() != null && !vo.getFileT().isEmpty()) {
	        if (!vo.getE_thum().isEmpty()) {
	            FileUploadUtil.fileDelete(vo.getE_thum());
	        }

	        String thum = FileUploadUtil.fileUpload(vo.getFileT(), "event");
	        vo.setE_thum(thum);
	    }
		
		if (vo.getFile1() != null && !vo.getFile1().isEmpty()) {
	        if (!vo.getE_img1().isEmpty()) {
	            FileUploadUtil.fileDelete(vo.getE_img1());
	        }

	        String img1 = FileUploadUtil.fileUpload(vo.getFile1(), "event");
	        vo.setE_img1(img1);
	    }
		
		if (vo.getFile2() != null && !vo.getFile2().isEmpty()) {
	        if (!vo.getE_img2().isEmpty()) {
	            FileUploadUtil.fileDelete(vo.getE_img2());
	        }

	        String img2 = FileUploadUtil.fileUpload(vo.getFile2(), "event");
	        vo.setE_img2(img2);
	    }
		
		result = eventDao.eventUpdate(vo);
		return result;
	}


	@Override
	public int eventDelete(EventVO vo) throws Exception {
		
		if(!vo.getE_img1().isEmpty()) {
			FileUploadUtil.fileDelete(vo.getE_img1());
		}
		if(!vo.getE_img2().isEmpty()) {
			FileUploadUtil.fileDelete(vo.getE_img2());
		}
		if(!vo.getE_thum().isEmpty()) {
			FileUploadUtil.fileDelete(vo.getE_thum());
		}
		
		return eventDao.eventDelete(vo);
	}
	
	
	@Override
	public EventVO updateForm(EventVO vo) {
		return eventDao.eventDetail(vo);
	}



	@Override
	public List<EventVO> getEventsByDate(@Param("selectedDate") String selectedDate) {
		List<EventVO> events = eventDao.getEventsByDate(selectedDate);
        return events;
	}

	@Override
	public int adminAllEventDelete(EventVO vo) throws Exception {
		 int result = 0;
         result = eventDao.adminAllEventDelete(vo);
         return result;
	}

	@Override
	public EventVO adminSearchEventNo(String eventId) {
		return eventDao.adminSearchEventNo(eventId);
	}

	





	

	
		
	
		



//	@Override
//	public List<EventVO> getEventsByDateRange(String startDate, String endDate) {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//	    String formattedStartDate = dateFormat.format(startDate);
//	    String formattedEndDate = dateFormat.format(endDate);
//
//	    // DAO 메서드 호출
//	    return eventDao.getEventsByDateRange(formattedStartDate, formattedEndDate);
//	}

	
	
	
	

	


	
}

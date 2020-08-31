package com.solarie.system.biz;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.solarie.common.base.BaseBiz;
import com.solarie.system.db.ConstType;
import com.solarie.system.mapper.ConstTypeMapper;

import java.util.List;

@Service
@Transactional
public class ConstTypeBiz extends BaseBiz<ConstTypeMapper,ConstType>{

	public List<ConstType> getAll(){
		return dao.selectAll();
	}
}

package com.solarie.system.biz;

import org.springframework.stereotype.Service;
import com.solarie.common.base.BaseBiz;
import com.solarie.system.db.UserOrg;
import com.solarie.system.mapper.UserOrgMapper;

@Service
public class UserOrgBiz extends BaseBiz<UserOrgMapper,UserOrg> {

	public void deleteByUserId(int userId){
		dao.deleteByUserId(userId);
	}
}

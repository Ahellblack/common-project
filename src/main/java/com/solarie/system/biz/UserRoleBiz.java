package com.solarie.system.biz;

import org.springframework.stereotype.Service;
import com.solarie.common.base.BaseBiz;
import com.solarie.system.db.UserRole;
import com.solarie.system.mapper.UserRoleMapper;

import java.util.List;

@Service
public class UserRoleBiz extends BaseBiz<UserRoleMapper,UserRole> {

	public void deleteByUserId(int userId){
		dao.deleteByUserId(userId);
	}
	
	public List<Integer> getRoleIdByUserId(int userId){
		return dao.getRoleIdByUserId(userId);
	}
}

package com.solarie.system.login.service;

import com.solarie.system.login.entity.SysDepartRoleUser;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @Description: 部门角色人员信息
 *
 * @Date:   2020-02-13
 * @Version: V1.0
 */
public interface ISysDepartRoleUserService extends IService<SysDepartRoleUser> {

    void deptRoleUserAdd(String userId, String newRoleId, String oldRoleId);
}

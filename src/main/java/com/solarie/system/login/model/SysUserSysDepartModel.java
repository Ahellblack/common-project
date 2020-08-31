package com.solarie.system.login.model;

import lombok.Data;
import com.solarie.system.login.entity.SysDepart;
import com.solarie.system.login.entity.SysUser;

/**
 * 包含 SysUser 和 SysDepart 的 Model
 *
 * @author sunjianlei
 */
@Data
public class SysUserSysDepartModel {

    private SysUser sysUser;
    private SysDepart sysDepart;

}

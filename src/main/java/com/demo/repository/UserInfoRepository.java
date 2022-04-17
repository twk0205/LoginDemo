package com.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.demo.bean.UserInfo;

@Repository
public interface UserInfoRepository extends JpaRepository<UserInfo, Long> {

	public UserInfo findByName(String name);
	
	@Query(value = "select u from UserInfo u order by u.id asc")
	public List<UserInfo> findAllByOrderByIdAsc();
	
    @Query(value = "select u from UserInfo u where u.account=:account")
    public UserInfo getUserByAccount(@Param("account") String account);

    @Query(value = "select u from UserInfo u where u.account like %:account% and u.name like %:name%")
	public List<UserInfo> findUserInfoListByAccountAndName(String account, String name);


}

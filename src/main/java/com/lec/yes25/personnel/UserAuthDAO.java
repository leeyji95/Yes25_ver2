package com.lec.yes25.personnel;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("userAuthDAO")
public class UserAuthDAO {

	@Autowired
    private SqlSessionTemplate sqlSession;
 
    public CustomUserDetails getUserById(String username) {
        return sqlSession.selectOne("com.lec.yes25.mapper.user_sql.selectUserById", username);
    }


	
}

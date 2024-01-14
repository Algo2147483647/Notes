# $MyBatis$

[TOC]

# Process

<img src="./assets/v2-11c9b17f5f79909cf4cbae580ba63493_r.jpg" alt="img" style="zoom:50%;" />

Database: 一个数据库叫 test_db ，其中有一个表叫 user 。user 表有三个字段：id, names, age。

```sql
Copy code
CREATE DATABASE test_db;
USE test_db;

CREATE TABLE user(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age INT
);
```

实体类: 

```java
public class User {
    private int id;
    private String name;
    private int age;
    
    // getters and setters
}
```

映射器接口

```java
public interface UserMapper {
    void insertUser(User user);
    User selectUser(int id);
    void updateUser(User user);
    void deleteUser(int id);
}
```

映射器XML: 将 SQL 查询和 UserMapper 接口的方法进行映射：

```xml
<mapper namespace="com.example.mybatis.UserMapper">
    <insert id="insertUser" parameterType="com.example.mybatis.User">
        INSERT INTO user (name, age) VALUES (#{name}, #{age})
    </insert>

    <select id="selectUser" parameterType="int" resultType="com.example.mybatis.User">
        SELECT * FROM user WHERE id = #{id}
    </select>

    <update id="updateUser" parameterType="com.example.mybatis.User">
        UPDATE user SET name=#{name}, age=#{age} WHERE id=#{id}
    </update>

    <delete id="deleteUser" parameterType="int">
        DELETE FROM user WHERE id=#{id}
    </delete>
</mapper>
```
应用程序: 使用 UserMapper 来操作数据库：

```java
try (SqlSession session = sqlSessionFactory.openSession()) {
    UserMapper mapper = session.getMapper(UserMapper.class);
    
    // 插入一个新用户
    User newUser = new User();
    newUser.setName("John");
    newUser.setAge(25);
    mapper.insertUser(newUser);
    session.commit();  // 注意：在进行更新操作后需要提交事务
    
    // 查询刚刚插入的用户
    User user = mapper.selectUser(newUser.getId());
    System.out.println(user.getName());
    
    // 更新用户信息
    user.setAge(26);
    mapper.updateUser(user);
    session.commit();
    
    // 删除用户
    mapper.deleteUser(user.getId());
    session.commit();
}
```
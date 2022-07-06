<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-05
  Time: 오후 8:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL 서버 아이디
    String password = "pw1234"; // MySQL 서버 비밀번호

//   1.드라이버 로딩
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("connect success!!!!");
    } catch (ClassNotFoundException e) {
        System.err.println(" !! <JDBC Driver Error> Driver load Error 오류오류: " + e.getMessage());
        e.printStackTrace();
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(url, user_name, password);
        System.out.println("Connect Success");
    } catch(SQLException e) {
        System.err.println("con Error:" + e.getMessage());
        e.printStackTrace();
    }

    Statement statement = con.createStatement();
    ResultSet resultSet = statement.executeQuery("select * from member");

    resultSet.next();

//  String name = resultSet.getString("name");
//  String email = resultSet.getString("email");
//  int num = resultSet.getInt("num");
//  String pw = resultSet.getString("pw");

//  System.out.println(name);

    // 3.해제
    try {
        if(con != null)
            con.close();
        statement.close();
        resultSet.close();
    } catch (SQLException e) {}
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>

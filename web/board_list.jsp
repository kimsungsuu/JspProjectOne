<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-05
  Time: 오후 3:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String boardTitle = "board_list";
%>
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

    String name = resultSet.getString("name");
    String email = resultSet.getString("email");
    int num = resultSet.getInt("num");
    String pw = resultSet.getString("pw");

    System.out.println(name);

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
    <title><%= boardTitle%>></title>
    <h1>게시판-목록</h1>
    <div id="search">
        <p>등록일</p>

    </div>
</head>
<nav id="board_list">
    <table>
        <thead>
            <tr>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>등록 일시</th>
                    <th>수정 일시</th>
            </tr>
        </thead>
        <tbody >
            <tr>
                <td>Java</td>
                <td>Okky 3월 세미나 서비스 개발자로 커리어 전환</td>
                <td>윤상진</td>
                <td>12</td>
                <td>2022.04.08</td>
                <td>2022.04.08</td>
            </tr>
        </tbody>
    </table>
</nav>
<body>


</body>
</html>

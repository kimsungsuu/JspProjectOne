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
<%--<%@ page import="board_bean" %>--%>
<%@ page import="java.util.Vector"%>

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

    // 3.해제
    try {
        if(con != null)
            con.close();
        statement.close();
        resultSet.close();
    } catch (SQLException e) {}
%>

<%
    request.setCharacterEncoding("EUC-KR");

    int totalRecord = 0;    //전체 레코드 수
    int numPerPage = 10;    // 페이지 당 레코드 수
    int pagePerBlock = 10;  //블럭당 페이지 수

    int totalPage=0;    //전체 페이지 수
    int totalBlock=0;   //전체 블럭 수

    int no
%>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= boardTitle%>></title>
    <h1>게시판-목록</h1>
    <div id="search">
        <p>등록일</p>
        <input type="date" | type = "month" | type="week" >
        <input type="date" | type = "month" | type="week" >
        <input type="text" placeholder="전체 카테고리" list="pack">
        <datalist id="pack">
            <option value="Java">Java</option>
            <option value="Javascript">Javascript</option>
            <option value="Database">Database</option>
        </datalist>

        <input type="text" placeholder="검색어를 입력해주세요(제목 + 작성자 + 내용)">
        <input type="submit"  value="검색">
    </div>
</head>
<body>
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
</body>
<footer>

    <input type="submit" value = "글쓰기">
</footer>
</html>

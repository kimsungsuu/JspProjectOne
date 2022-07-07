<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-05
  Time: 오후 3:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR" %>
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
    int total = 0;

    Statement stmt = con.createStatement();

    String sqlCount = "SELECT * FROM member";
    ResultSet rs = stmt.executeQuery(sqlCount);

    if(rs.next()){
        total = rs.getInt(1);
    }
    rs.close();

    String sqlList = "SELECT num,category,title,writer,create_date,views,mod_date FROM member ORDER BY num DESC";
    rs = stmt.executeQuery(sqlList);


%>

<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
    <title><%= boardTitle%>></title>

<%--    해당하는 url로 이동할 수 있도록 자바스크립트 함수 선언--%>
    <script type="text/javascript">
        function gourl(url){
            location.href=url;
        }
    </script>

    <h1>게시판-목록</h1>
    <div id="search">
        <label>등록일<input type="date" | type = "month" | type="week" ></label>
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
<form name="searchform" action="" method="get"></form>
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
<%--        게시물이 없다면--%>
        <%
        if(total==0){
        %>
        <tr>
            <td>등록된 게시물이 없습니다.</td>
        </tr>
<%--        게시물이 존재한다면 출력--%>
        <%
            }else{
            while(rs.next()){
                int num = rs.getInt("num");
                String category = rs.getString("category");
                String title = rs.getString("title");
                String writer = rs.getString("writer");
                int views = rs.getInt("views");
                Date mod_date = rs.getDate("mod_date");
                Date create_date =rs.getDate("create_date");
        %>
        <tr>
            <td style="width:100px"><%=category%></td>
<%--            title을 클릭하면 게시물을 볼 수 있도록 설정--%>
            <td ><a href="board_view.jsp?num=<%=num%>>"><%=title%></a></td>
            <td ><%=writer%></td>
            <td ><%=views%></td>
            <td ><%=create_date%></td>
            <td ><%=mod_date%></td>
        </tr>
        <%
            }
        }
            // 3.해제
            try {
                if(con != null)
                    con.close();
                stmt.close();
                rs.close();
            } catch (SQLException e) {}
        %>
        </tbody>
        <tfoot>
            <tr>
                <td align="center" colspan="5"></td>
            </tr>
        </tfoot>
    </table>
</nav>
</body>
<footer>
    <p>
        <input type="submit" value = "글쓰기" onclick="gourl('board_write.jsp')">
    </p>
</footer>
</html>
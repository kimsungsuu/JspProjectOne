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

    String sqlCount = "SELECT COUNT(*) FROM member";
    ResultSet rs = stmt.executeQuery(sqlCount);

    if(rs.next()){
        total = rs.getInt(1);
    }

    //    String sqlList = "SELECT num,category,title,writer,date,text,available,views,mode_date FROM member ORDER BY num DESC";
//    rs = stmt.executeQuery(sqlList);


%>

<%
//    request.setCharacterEncoding("EUC-KR");
    //request 메소드가 import 되어 있지 않아서 에러가 발생하는것으로 예상한다.
    //beans 자바 파일 또는 Mgr 자바 파일 안에 import 되어있을 것으로 예상한다.

    int totalRecord = 0;    //전체 레코드 수
    int numPerPage = 10;    // 페이지 당 레코드 수
    int pagePerBlock = 10;  //블럭당 페이지 수

    int totalPage=0;    //전체 페이지 수
    int totalBlock=0;   //전체 블럭 수

    int nowPage=1;  // 현재 페이지
    int nowBlock=1; // 현재 블럭

    //한 페이지당 출력되는 게시물 수.
    int start=0;
    int end=10;

    //현재 읽어온 게시물 수
    int listSize=0;

    //검색에 사용될 변수들(제목 + 작성자 + 내용)
//    String title="", writer ="", text ="";


%>

<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
    <title><%= boardTitle%>></title>
    <script type="text/javascript">
        function gourl(url){
            location.href=url;
        }
    </script>
    <h1>게시판-목록</h1>
<%--    CSS--%>
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
        <colgroup>
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
        </colgroup>
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
        <%
        if(total==0){
        %>
        <tr>
            <td>등록된 게시물이 없습니다.</td>
        </tr>
        <%
            }else{
            while(rs.next()){
                int num = rs.getInt(1);
                String category = rs.getString(2);
                String title = rs.getString(3);
                String writer = rs.getString(4);
                int views = rs.getInt(6);
                Date mod_date = rs.getDate(7);
                Date create_date =rs.getDate(9);
        %>
        <tr>
            <td style="width:100px"><%=num%></td>
            <td style="width:100px"><%=category%></td>
            <td ><a href="board_view.jsp?num=<%=num%>>"><%=title%></a></td>
            <td ><%=writer%></td>
            <td ><%=views%></td>
            <td ><%=create_date%></td>
            <td ><%=mod_date%></td>

            <td style="width:100px">Java</td>
            <td ><a href="board_view.jsp?num=<%=num%>>">Okky 가나다라마바사 반갑습니다</a></td>
            <td >김성수</td>
            <td >12</td>
            <td >2022.7.6</td>
            <td >2022.7.6</td>
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
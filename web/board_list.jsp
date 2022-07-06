<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-05
  Time: ���� 3:48
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
    String user_name = "root"; //  MySQL ���� ���̵�
    String password = "pw1234"; // MySQL ���� ��й�ȣ

//   1.����̹� �ε�
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("connect success!!!!");
    } catch (ClassNotFoundException e) {
        System.err.println(" !! <JDBC Driver Error> Driver load Error ��������: " + e.getMessage());
        e.printStackTrace();
    }

    // 2.����
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

    // 3.����
    try {
        if(con != null)
            con.close();
        statement.close();
        resultSet.close();
    } catch (SQLException e) {}
%>

<%
//    request.setCharacterEncoding("EUC-KR");
    //request �޼ҵ尡 import �Ǿ� ���� �ʾƼ� ������ �߻��ϴ°����� �����Ѵ�.
    //beans �ڹ� ���� �Ǵ� Mgr �ڹ� ���� �ȿ� import �Ǿ����� ������ �����Ѵ�.

    int totalRecord = 0;    //��ü ���ڵ� ��
    int numPerPage = 10;    // ������ �� ���ڵ� ��
    int pagePerBlock = 10;  //���� ������ ��

    int totalPage=0;    //��ü ������ ��
    int totalBlock=0;   //��ü �� ��

    int nowPage=1;  // ���� ������
    int nowBlock=1; // ���� ��

    //�� �������� ��µǴ� �Խù� ��.
    int start=0;
    int end=10;

    //���� �о�� �Խù� ��
    int listSize=0;

    //�˻��� ���� ������(���� + �ۼ��� + ����)
    String title="", writer ="", text ="";


%>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= boardTitle%>></title>
    <h1>�Խ���-���</h1>
    <div id="search">
        <p>�����</p>
        <input type="date" | type = "month" | type="week" >
        <input type="date" | type = "month" | type="week" >
        <input type="text" placeholder="��ü ī�װ�" list="pack">
        <datalist id="pack">
            <option value="Java">Java</option>
            <option value="Javascript">Javascript</option>
            <option value="Database">Database</option>
        </datalist>

        <input type="text" placeholder="�˻�� �Է����ּ���(���� + �ۼ��� + ����)">
        <input type="submit"  value="�˻�">
    </div>
</head>
<body>
<nav id="board_list">
    <table>
        <thead>
        <tr>
            <th>ī�װ�</th>
            <th>����</th>
            <th>�ۼ���</th>
            <th>��ȸ��</th>
            <th>��� �Ͻ�</th>
            <th>���� �Ͻ�</th>
        </tr>
        </thead>
        <tbody >
        <tr>
            <td>Java</td>
            <td>Okky 3�� ���̳� ���� �����ڷ� Ŀ���� ��ȯ</td>
            <td>������</td>
            <td>12</td>
            <td>2022.04.08</td>
            <td>2022.04.08</td>
        </tr>
        </tbody>
    </table>
</nav>
</body>
<footer>

    <input type="submit" value = "�۾���">
</footer>
</html>

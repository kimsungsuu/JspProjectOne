<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-08
  Time: 오전 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>board_modify</title>
</head>
<body>
<form id="board_modify" name = "board_modify" action="board_modify_ok.jsp" method="post" onsubmit="return BoardWriteChk();">
    <table>
        <tbody class="classification">
        <tr>
            <th>카테고리</th>
            <td><select id="category" name="category">
                <option value="Java">Java</option>
                <option value="JavaScript">JavaScript</option>
                <option value="Database">Database</option>
            </select></td>
        </tr>
        <tr>
            <th>등록 일시</th>
            <td></td>
        </tr>
        <tr>
            <th>수정 일시</th>
            <td></td>
        </tr>
        <tr>
            <th>조회수</th>
            <td></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>
                <input type="text" id="writer" name="writer" maxlength="50">
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="text" placeholder="비밀번호" id="password" name="password" maxlength="50">
        </tr>
        <tr>
            <th>제목</th>
            <td><input type="text" id="title" name="title" maxlength="50"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="2">
                <textarea name="text" id="text" cols="75" rows="15"></textarea>
            </td>
        </tr>
        <tr>
            <th>파일 첨부</th>
            <td> </td>
        </tr>
        </tbody>
    </table>
    <p>
        <input type="submit" value="저장">
        <input type="button" value="취소" onclick="gourl('board_list.jsp')">
    </p>
</form>
</body>
</html>

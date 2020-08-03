<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link href="https://fonts.googleapis.com/css2?family=Sniglet&display=swap" rel="stylesheet">
<title>로그아웃</title>
<style>
	
body,
html {
    width: 100%;
    height: 100%;
    overflow: hidden;
    background-image: linear-gradient( rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
    url("https://static.pexels.com/photos/93750/pexels-photo-93750-large.jpeg");
    background-repeat: no-repeat;
    background-size: cover;
    font-family: 'Rubik', sans-serif;
}

button {
    width: 500px;
    height: 100px;
    font-size: 50px;
    margin: auto;
    line-height: 100px;
    text-decoration: none;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    display: block;
    /* border: solid 1px black; */
    border: none;
    border-radius: 70px;
    text-align: center;
    /* font-family: Arial, sans-serif; */
    /* text-transform: uppercase; */
    /* color: #666; */
    transition: all 500ms;
    -webkit-transition: all 500ms;
    -moz-transition: all 500ms;
    z-index: 1;
    background-color: rgb(240, 240, 240);
    color: rgb(29, 28, 28);
}

button:after,
button:before {
    display: block;
    background: rgb(228, 204, 188);
    width: 0;
    height: 100px;
    content: "";
    position: absolute;
    -webkit-transition: all 500ms;
    -moz-transition: all 500ms;
    -ms-transition: all 500ms;
    -o-transition: all 500ms;
    transition: all 500ms;
    z-index: -1;
    font-family: 'Rubik', sans-serif;
}

button:after {
    bottom: 0px;
    left: 0px;
    /* width: 50% */
    border : none;
    border-radius: 70px;
    font-family: 'Rubik', sans-serif;
}

button:before {
    top: 0px;
    right: 0px;
    border-radius: 70px;
    font-family: 'Rubik', sans-serif;
}

button:hover:after,
button:hover:before{
  width: 100%;
  border-radius: 70px;
  border : none;
  font-family: 'Rubik', sans-serif;
}

button:hover{
    cursor: pointer;
    background-color: #fff;
    color:black;
}

.wrapper {
  height: 60vh;
  display: flex;
  align-items: center;
  justify-content: center;
}
.typing-demo {
  width: 16ch;
  animation: typing 2s steps(22), blink 0.5s step-end infinite alternate;
  white-space: nowrap;
  color : #fff;
  font-weight: 600;
  overflow: hidden;
  border-right: 5px solid white;
  /* font-family: monospace; */
  font-size: 4.5em;
}
@keyframes typing {
  from {
    width: 0;
  }
}
@keyframes blink {
  50% {
    border-color: transparent;
  }
}
</style>
</head>
<body>
    <div class="wrapper">
        <div class="typing-demo">
            Logout 되었습니다.
        </div>
    </div>
<form action="${pageContext.request.contextPath}/personnel/logout" method='post'>
<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
<button style=" font-family: 'Rubik', sans-serif;"><i class="fas fa-arrow-circle-left"></i>  Move to Login</button>
<!-- <a>Logout</a> -->
</form>
</body>
</html>


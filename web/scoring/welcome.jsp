<%-- 
    Document   : welcome
    Created on : 22 Jun 2024, 2:04:43 pm
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome To RG SCORING</title>
    </head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
.loading *,
.loading *:before,
.loading *:after {
  animation-play-state: paused !important;
}

body {
  background: rgb(211, 000, 142);
  background: radial-gradient(
    circle,
    rgba(204, 182, 142, 0.8996192226890756) 33%,
    rgba(251, 237, 211, 0.8576024159663865) 100%
  );
}

.test {
  opacity: 40%;
  width: 100%;
}

.art-board {
  opacity: 0;
  width: 1000px;
  height: 668px;
  min-width: 1000px;
  position: relative;
  animation: fade_in 0.9s 0.8s forwards cubic-bezier(0.17, 0.77, 0.38, 0.87);
}

@media only screen and (max-width: 600px) {
  html{
  opacity: 0;
  width: 800px;
  height: 500px;
  min-width: 1000px;
  position: relative;
  animation: fade_in 0.9s 0.8s forwards cubic-bezier(0.17, 0.77, 0.38, 0.87);
}
}

.asset {
  position: absolute;
  transform-style: preserve-3d;
  will-change: transform;
}

.asset img {
  transform: scale(0.64);
  user-drag: none;
  -webkit-user-drag: none;
  user-select: none;
  -moz-user-select: none;
  -webkit-user-select: none;
}

.asset1 {
  top: 190px;
  left: -83px;
  animation: floatDown 3.6s ease-in-out infinite;
}

.asset2 {
  top: 370px;
  left: 77px;
  animation: floatUp 3.6s 0.1s ease-in-out infinite;
}

.asset3 {
  top: 142px;
  left: 117px;
  animation: floatLeft 3.6s 0.2s ease-in-out infinite;
}

.asset4 {
  top: 338px;
  left: 60px;
  animation: floatUp 3.6s 0.3s ease-in-out infinite;
}

.asset5 {
  top: 397px;
  left: 409px;
  animation: floatLeft 3.6s 0.1s ease-in-out infinite;
}

.asset6 {
  top: 100px;
  left: 397px;
  animation: floatUp 3.6s 0.2s ease-in-out infinite;
}

.asset7 {
  top: -15px;
  left: 291px;
  animation: floatDown 3.6s 0.3s ease-in-out infinite;
}

.asset8 {
  top: 112px;
  left: 327px;
  animation: floatUp 3.6s 0.1s ease-in-out infinite;
}

.asset9 {
  top: 57px;
  left: 569px;
  animation: floatRight 3.6s 0.2s ease-in-out infinite;
}

.asset10 {
  top: 467px;
  left: 525px;
  animation: floatRight 3.6s 0.3s ease-in-out infinite;
}

.asset11 {
  top: 397px;
  left: 597px;
  animation: floatLeft 3.6s 0.1s ease-in-out infinite;
}

.asset12 {
  top: 358px;
  left: 554px;
  animation: floatRight 3.6s 0.2s ease-in-out infinite;
}

.asset13 {
  top: 356px;
  left: 593px;
  animation: floatLeft 3.6s 0.3s ease-in-out infinite;
}

.asset14 {
  top: 256px;
  left: 853px;
  animation: floatUp 3.6s 0.1s ease-in-out infinite;
}

.asset15 {
  top: 145px;
  left: 743px;
  animation: floatDown 3.6s 0.2s ease-in-out infinite;
}

.asset16 {
  top: 191px;
  left: 820px;
  animation: floatDown 3.6s 0.3s ease-in-out infinite;
}
.asset17 {
  top: 163px;
  left: 793px;
  animation: floatUp 3.6s 0.1s ease-in-out infinite;
}
.asset18 {
  top: 167px;
  left: 732px;
  animation: floatLeft 3.6s 0.2s ease-in-out infinite;
}

.container {
  display: flex;
  justify-content: center;
  align-items: center;
}

.title {
  position: absolute;
  color: white;
  opacity: 90%;
  line-height: 0.82;
  font-size: 100px;
  font-family: "neue-haas-grotesk-display", sans-serif;
  font-weight: 900;
  font-style: normal;
  letter-spacing: -2px;
  top: 138px;
  left: 202px;
  opacity: 0;
  animation: showMain 0.5s 0.6s forwards cubic-bezier(0.17, 0.77, 0.38, 0.87);
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

@keyframes floatUp {
  0% {
    transform: translate3d(0, 0, 0);
  }
  50% {
    transform: translate3d(0, -5%, 0);
  }
  100% {
    transform: translate3d(0, 0, 0);
  }
}

@keyframes floatDown {
  0% {
    transform: translate3d(0, 0, 0);
  }
  50% {
    transform: translate3d(0, 5%, 0);
  }
  100% {
    transform: translate3d(0, 0, 0);
  }
}

@keyframes floatRight {
  0% {
    transform: translate3d(0, 0, 0);
  }
  50% {
    transform: translate3d(-5%, 0, 0);
  }
  100% {
    transform: translate3d(0, 0, 0);
  }
}

@keyframes floatLeft {
  0% {
    transform: translate3d(0, 0, 0);
  }
  50% {
    transform: translate3d(5%, 0, 0);
  }
  100% {
    transform: translate3d(0, 0, 0);
  }
}

@keyframes fade_in {
  100% {
    opacity: 1;
  }
}

@keyframes show {
  0% {
    opacity: 0;
    transform: translate(0, -20px);
  }

  100% {
    opacity: 1;
    transform: translate(0, 0);
  }
}

@keyframes showMain {
  0% {
    opacity: 0;
    transform: translate(0, 50px);
  }

  100% {
    opacity: 1;
    transform: translate(0, 0);
  }
}


    </style>
    <body>
       
        <!--<a href="LiveIndividualScore" class='btn btn-lg btn-primary mt-5 text-center  d-flex align-items-center justify-content-center'>View Gymnast Score</a>-->
<div id="main" class="container-fluid loading d-flex align-items-center justify-content-center mx-0 my-0">
  <div class="art-board">
    <!--<div class="asset asset1"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698865081/floating/Asset1.png" alt=""></div>-->
    <div class="asset asset2"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698865081/floating/Asset2.png" alt=""></div>
    <div class="asset asset4"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset4.png" alt=""></div>
    <div class="asset asset5"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset5.png" alt=""></div>
    <div class="asset asset6"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset6.png" alt=""></div>
    <!--<div class="asset asset7"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset7.png" alt=""></div>-->
    <div class="asset asset8"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset8.png" alt=""></div>
    <div class="asset asset9"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset9.png" alt=""></div>
    <div class="asset asset10"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698874357/floating/Asset10.png" alt=""></div>
    <div class="asset asset11"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698874658/floating/Asset11.png" alt=""></div>
    <div class="asset asset12"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset12.png" alt=""></div>
    <div class="asset asset13"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset13.png" alt=""></div>
    <a href="ListEvent"> <h4 class="title">Welcome To Rythmic Gymnastic Scoring System</h4> </a>

    <div class="asset asset3"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698870354/floating/Asset18.png" alt=""></div>
    <div class="asset asset14"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698875726/floating/Asset17.png" alt=""></div>
    <!--<div class="asset asset15"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698875916/floating/Asset4.png" alt=""></div>-->
    <div class="asset asset16"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698876068/floating/Asset16.png" alt=""></div>
    <div class="asset asset17"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698876356/floating/Asset17.png" alt=""></div>

    <div class="asset asset18"><img src="https://res.cloudinary.com/jasuaje/image/upload/v1698876424/floating/Asset18.png" alt=""></div>
   
    <!--             <img class="test" src="https://res.cloudinary.com/jasuaje/image/upload/v1698862868/efnmy8h59frls46wceps.png" alt=""> -->
  </div>
</div>
          <a href="ListEvent" style=" font-family: 'neue-haas-grotesk-display', sans-serif;font-weight:700" class="mx-5 mt-5 mb-0 btn d-flex align-items-center justify-content-center text-dark shadow p-3 mb-5 bg-body-tertiary rounded">View Score Details</a>
       
        <script>
            window.addEventListener("load", () => {
  const elem = document.getElementById("main");
  elem.classList.remove("loading");
});

        </script>
    </body>
</html>

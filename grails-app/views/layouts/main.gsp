<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/> Question</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
    <meta name="author" content="Michael Meng">
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="font-awesome.less"/>
    <asset:stylesheet src="application.less"/>
    <g:layoutHead/>
</head>

<body>
<a class="sr-only" href="#content">Skip to main content</a>

<!-- Docs master nav -->
<header class="navbar navbar-static-top bs-demo-nav" id="top" role="banner">
    <div class="container">

        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="/" class="navbar-brand"><i class="fa fa-twitter"></i> Grails Demo</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
            <ul class="nav navbar-nav">
                <li>
                    <g:link uri="/">Getting started</g:link>
                </li>
                <li>
                    <a href="../css">Questions</a>
                </li>
                <sec:ifLoggedIn>
                <li>
                    <g:link uri="/user">People</g:link>
                </li>
                </sec:ifLoggedIn>
            </ul>
            <sec:ifLoggedIn>
                <button type="button" class="btn btn-header navbar-btn">Create a Question</button>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="http://expo.getbootstrap.com"><i class="fa fa-bell fa-lg icon-animated-bell"></i></a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" alt="Logged as <sec:username/>">
                            <i class="fa fa-user fa-lg"></i> <sec:username/>
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller='j_spring_security_logout'><i class="fa fa-sign-out"></i> Logout</g:link></li>
                        </ul>
                    </li>
                </ul>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <g:form url="${request.contextPath}/j_spring_security_check" method='POST'
                        class="navbar-form navbar-right" role="form">
                    <div class="form-group">
                        <label class="sr-only" for="username">User Name</label>
                        <input name="j_username" id="username" class="form-control" placeholder="User Name"/>
                    </div>
                    <div class="form-group">
                        <label class="sr-only" for="password">Password</label>
                        <input type="password" class="form-control" name="j_password" id="password" placeholder="Password"/>
                    </div>
                    <g:actionSubmit class="btn btn-default" value="Login" />
                </g:form>
            </sec:ifNotLoggedIn>
        </nav>
    </div>
</header>
<div class="container">
    <g:layoutBody/>
</div>
<footer class="bs-docs-footer">
    <p>Designed and built upon <a href="//grails.org">Grails</a> and <a href="//getbootstrap.com">Bootstrap</a></p>
    <p>All the work is under <a href="http://www.apache.org/licenses/LICENSE-2.0">APL v2.0</a></p>
</footer>
<asset:javascript src="jquery-2.1.1.min.js"/>
<asset:javascript src="bootstrap.min.js"/>
</body>
</html>

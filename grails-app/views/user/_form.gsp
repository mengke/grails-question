<%@ page import="org.ibntab.User" %>



<div class="form-group ${hasErrors(bean: userInstance, field: 'username', 'has-error')} required">
    <label for="username" class="col-sm-2 control-label">
        <g:message code="user.username.label" default="Username"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-10">
        <g:textField class="form-control" name="username" required="" value="${userInstance?.username}"/>

    </div>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'has-error')} required">
    <label for="password" class="col-sm-2 control-label">
        <g:message code="user.password.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-10">
        <g:textField class="form-control" name="password" required="" value="${userInstance?.password}"/>

    </div>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'accountExpired', 'has-error')} ">
    <label for="accountExpired" class="col-sm-2 control-label">
        <g:message code="user.accountExpired.label" default="Account Expired"/>

    </label>

    <div class="col-sm-10">
        <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}"/>

    </div>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'accountLocked', 'has-error')} ">
    <label for="accountLocked" class="col-sm-2 control-label">
        <g:message code="user.accountLocked.label" default="Account Locked"/>

    </label>

    <div class="col-sm-10">
        <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}"/>

    </div>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'enabled', 'has-error')} ">
    <label for="enabled" class="col-sm-2 control-label">
        <g:message code="user.enabled.label" default="Enabled"/>

    </label>

    <div class="col-sm-10">
        <g:checkBox name="enabled" value="${userInstance?.enabled}"/>

    </div>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'passwordExpired', 'has-error')} ">
    <label for="passwordExpired" class="col-sm-2 control-label">
        <g:message code="user.passwordExpired.label" default="Password Expired"/>

    </label>

    <div class="col-sm-10">
        <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}"/>

    </div>
</div>


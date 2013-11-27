

<%@ page import="socnet.UserDTO" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userDTO.label', default: 'UserDTO')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span id="loginHeader"><g:loginControl /></span>
        </div>
        <div class="body">
            <h1>Update My Account</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
              
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop hidden">
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'apiKey', 'errors')}">
                                    <g:textField name="apiKey" value="${fieldValue(bean: userInstance, field: 'apiKey')}" />
                                </td>
                            </tr>
                        
                       <tr class="prop">
                            <td valign="top" class="name"><g:message code="userDTO.apiKey.label" default="Api Key" /></td>
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "apiKey")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="userDTO.login.label" default="Login" /></td>

                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "login")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="userDTO.name.label" default="Name" /></td>
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "name")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="userDTO.email.label" default="Email" /></td>
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>

                        </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="defaultContacts"><g:message code="userDTO.defaultContacts.label" default="Default Contacts" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'defaultContacts', 'errors')}">
                                    <g:textField name="defaultContacts" value="${fieldValue(bean: userInstance, field: 'defaultContacts')}" />
                                </td>
                            </tr>
                        
                            
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

package socnet
import java.security.MessageDigest
import sun.misc.BASE64Encoder
import sun.misc.CharacterEncoder
import java.util.UUID;
import edu.ncirl.Stopper
import org.codehaus.groovy.grails.commons.ConfigurationHolder


class UserController {
    def mailService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST",compare: "POST",collaborate: "collaborate",confirm: "GET"]

    def shaPassword(str) {
        MessageDigest md = MessageDigest.getInstance('SHA')
        md.update(str.getBytes('UTF-8'))
        return (new BASE64Encoder()).encode(md.digest())
    }

    def authenticate = {
        def loginUser = new LoginUser(params)
        if (loginUser.validate()) {
            def user = User.findByLoginAndHashedPassword(params.login, shaPassword(params.password))
            if(user){
                if ( user.isConfirmed()) {
                    session.user = user
                    flash.message = "Hello ${user.name}!"
                    redirect(action:"show", model: [userInstance: user])
                }
                else {
                    flash.message = "Check email inbox for confirmation process !"
                    render(view:"login", model: [loginUser: loginUser])
                }
            }else{
                flash.message = "Invalid User/Password combination. Please try again."
                render(view:"login", model: [loginUser: loginUser])
            }
        }
        else{
            flash.message = "Incomplete login details . Please try again."
            render(view: "login", model: [loginUser: loginUser])
        }
    }
    def logout = {
        flash.message = "Goodbye ${session.user.name}"
        session.user = null
        redirect(controller:"api", action:"demo")
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

    def login = {
        def loginUserInstance = new LoginUser()
        loginUserInstance.properties = params
        return [loginUserInstance: loginUserInstance]
    }

    def save = {
        def userInstance = new User(params)
        if (params.password != params.confirmPassword) {
            flash.message = "The passwords you entered do not match."
            render(view: "create", model: [userInstance: userInstance])
        }

        userInstance.hashedPassword = shaPassword(params.password)
        userInstance.apiKey = UUID.randomUUID();

        if (userInstance.save(flush: true)) {
            //send confirmation email
            def sendTo = "${userInstance.email}"
            def message =  "Hi ${userInstance.name}, \n Your API-Key is ${userInstance.apiKey} \n follow the link to confirm your registration \n ${ConfigurationHolder.config.grails.serverURL}/user/confirm?api=${userInstance.apiKey}"
            try {
                mailService.sendMail {
                    to sendTo
                    from "sean535@gmail.com"
                    subject "Welcome To The Profiler Application"
                    body message
                }
            }
            catch (javax.mail.AuthenticationFailedException e)
            {
                render(view: "error")
            }
            flash.message = "Registration Complete, Check Inbox for confirmation email"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        if (session.user) {
            def userInstance = User.findByApiKey(session.user.apiKey)
            if (!userInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "demo")
            }
            else {
                [userInstance: userInstance]
            }
        }
    }

    def edit = {
        if (session.user){
            def userInstance = User.findByApiKey(session.user.apiKey)
            if (!userInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "demo")
            }
            else {
                def userDto = new UserDTO()
                userDto.name = userInstance.name
                userDto.apiKey = userInstance.apiKey
                userDto.login = userInstance.login
                userDto.email = userInstance.email
                userDto.defaultContacts = userInstance.defaultContacts
                return [userInstance: userDto]
            }
        }
    }

    def update = {
        def userInstance = User.findByApiKey(params.apiKey)
        if (userInstance) {           
            userInstance.defaultContacts = params.defaultContacts as int
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.name])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "demo")
        }
    }

    def confirm = {
        if (params.api) {
            def userInstance = User.findByApiKey(params.api)
            if (userInstance) {
                try {
                    userInstance.status = 1
                    userInstance.save()
                    flash.message = "Successful Confirmation, Please Logon "
                    redirect(action: "login")
                }
                catch (org.springframework.dao.DataIntegrityViolationException e) {
                    flash.message = "${message(code: 'default.not.saved.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                    redirect(action: "show", id: params.id)
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "demo")
            }
        }
    }
}

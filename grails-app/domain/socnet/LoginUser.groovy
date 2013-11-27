package socnet

class LoginUser {

    static constraints = {
        login(blank:false)
        password(blank:false)
    }
    String login
    String password
}

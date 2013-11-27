package socnet

class User {

    static mapping = {
       confirmPassword false
       password false
    }

    static constraints = {
        login(size:5..20, blank:false,unique:true)
        password(size:5..15, blank:false,password:true)
        email(email:true, blank:false,unique:true)
        name(blank: false)
    }

    String login
    String password
    String hashedPassword
    String confirmPassword
    String name
    String email
    int defaultContacts = 5
    String apiKey
    int status = 0 //0 registered not confirmed,1 registered and confirmed

    static transients = [ 'confirmPassword','password']

    String toString(){
        name
    }

    Boolean isConfirmed()
    {
        return status == 1
    }
    Boolean notConfirmed()
    {
        return status == 0
    }

}

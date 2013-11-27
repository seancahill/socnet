package socnet

class UserDTO {

    static constraints = {
        defaultContacts(min:1,max:20,nullable: false)
    }

    String login
    String name
    String email
    String apiKey
    int defaultContacts


    String toString(){
        name
    }
}

package socnet

class UserStop {

    static constraints = {
    }
    String word
    String apiKey
    static mapping = {
        apiKey index:true
        version false
    }
}

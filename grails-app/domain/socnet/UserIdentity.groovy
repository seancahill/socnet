package socnet

class UserIdentity {
    String identity
    String profile
    String likes
    String apiKey
    static mapping = {
        identity index:true
        version false
    }
    static constraints = {
        identity(blank:false)
    }
    boolean equals(other) { other?.id == id }

    int hashCode() { id ?: 0 }
}

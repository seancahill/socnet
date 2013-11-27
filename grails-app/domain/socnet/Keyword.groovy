package socnet

class Keyword {
    String keyword
    String profileType
    String apiKey
    List users
    static hasMany = [ users: UserIdentity]
    static mapping = {
        keyword index:true
        version false
    }
    static constraints = {
        keyword(blank:false)
        profileType(blank:false)
    }
    boolean equals(other) { other?.id == id }

    int hashCode() { id ?: 0 }
}

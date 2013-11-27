package socnet

class DemoUser {

    static constraints = {
    }
    String country
    String state
    String town
    String bio
    String needs
    String likes
    String name
    String identity

    DemoUser(){}
    DemoUser(String c,String s,String t, String b, String n,String l, String nme, String id)
    {
        country = c
        state = s
        town = t
        bio = b
        needs = n
        likes = l
        name= nme
        identity = id
    }
}

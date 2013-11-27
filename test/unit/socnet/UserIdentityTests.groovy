package socnet

import grails.test.*

class UserIdentityTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }


    void testCreateSomething() {
        // Mock the domain class.
        def testInstances=[]
        mockDomain(UserIdentity, testInstances)
        assertEquals(0, UserIdentity.count())
        new UserIdentity(identity:"123456").save()
        assertEquals(1, UserIdentity.count())

        //mockDomain(UserIdentity)
        //def s = new UserIdentity(identity:"123457")
        //s.save()
        //assert s.id != null
        //s = UserIdentity.get(s.id)
        //assert s != null
    }
    void testContraints() {
        def existingUser = new UserIdentity(identity: "123456", apiKey: "1234-5678-9012-3456")
        mockForConstraintsTests(UserIdentity, [ existingUser ])
        def user = new UserIdentity()
		assertFalse user.validate()
		assertEquals "nullable", user.errors["identity"]
		assertEquals "nullable", user.errors["apiKey"]

    }
}

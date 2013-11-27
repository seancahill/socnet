/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import socnet.*

def apps = Application.findByName('mingle')
def locs = apps.locations
for (loc in locs) {
    def keywords = loc.keywords
    for (key in keywords) {
        print key.keyword + ' ' + key.profileType
        def users = key.users
        for (user in users) {
            print ' ' + user.identity
        }
        println ''
        }
        }
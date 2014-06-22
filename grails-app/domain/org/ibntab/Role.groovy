package org.ibntab

class Role {

	String authority

	static mapping = {
        table 'sc_role'
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}

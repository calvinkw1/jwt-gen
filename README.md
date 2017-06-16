### Installation

	git clone https://github.com/calvinkw1/jwt-gen.git

### Usage
Add the path to `/jwt-gen/bin` to your `$PATH`. Run `jwt-gen`:

	Input issuer user ID..
	user1234
	Input issuer email..
	example@go.com
	Input expiration(exp) time in hours (1/2/3/4/etc)..
	1
	Any additional claims? (y/n)
	y
	Please enter key name
	foo
	Please enter value
	bar
	Any additional claims? (y/n)
	n
	Initializing token type JWT with HS256 algorithm..
	Input secret..
	mysecret
	Generating JWT...
	JWT successfully copied to clipboard!

### **Challenge 2**

#### **The task**

**Build an CLI for generating Json Web Tokens (JWT's)**

The CLI should be able to take multiple key value pairs as input, and copy the generated JWT to your clipboard.

Required inputs are user_id and email. In addition, other key/value pairs can also be entered


***An example session could look like this:***

    $ jwt_me
    Starting with JWT token generation.
    Enter key 1
    $ user_id
    Enter user_id value
    $ 12312
    Enter key 2
    $ email
    Enter email value
    $ something
    Invalid email entered! Enter email value
    $ syed@thredup.com
    Any additional inputs? (yes/no)
    $ no
    The JWT has been copied to your clipboard!
    
  ***What we are looking for:***
  - General programming style
  - Test coverage
  - CLI ease of use

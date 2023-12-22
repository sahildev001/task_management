import { findOne, create } from '../model/user';
import { hash, compare } from 'bcrypt';
import { sign } from 'jsonwebtoken';

const SECRET_KEY = process.env.SECRET_KEY;

const signup = async (req,res) =>{
    const {username, email, password} = req.body;
    try{
        const validateStatus = validateSignUp(req.body);

        if (!validateStatus.valid) {
            return res.status(400).json({ message: validateStatus.message });
            }

        // Check existing user
        const existingUser = await findOne({ email: email });

        if (existingUser) {
        return res.status(400).json({ message: "User already exists go to Login" });
        }

        // create hashed password
        const hashedPassword = await hash(password,10);

        const result = await create({
            email: email,
            username : username,
            password: hashedPassword
        });

        //Generate token
        const token = sign({email: result.email, id: result._id}, SECRET_KEY);
        res.status(200).json({token: token, data: result});
        
    }catch(error){
    console.error(`error on signUP ${error}`);
    res.status(500).json({message: "Internal server error"});
    }
}


function validateSignUp(requestBody) {
    const {username, email, password} = requestBody;
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    const isValidEmail = emailRegex.test(email);

    if((!username) || username == ""){
        return { valid: false, message: "username should not be empty." };
    }else if((!email) || email == ""){
        return { valid: false, message: "email should not be empty." };
    }else if(!isValidEmail){
        return { valid: false, message: "use valid email." };
    }else if((!password) || password == ""){
        return {valid: false, message: "password should not be empty."};
    }else if(password.length <6){
        return { valid: false, message: "password should be 6 letters long." };
    }

    return { valid: true };
    


}

const signin = async (req, res)=>{
    const {email, password} = req.body;
    try{
        const validate = validateSignin(req.body);
        if(!validate.valid){
            return res.status(400).json({message : validate.message});
        }

    const result =  await findOne({
        email : email
        });

        if(!result){
            return res.status(400).json({message : 'user does not exist'});
        }

        // compare password
        const isValidPassword = await  compare(password, result.password);

        if(!isValidPassword){
            return res.status(400).json({message: "Invalid password"});
        }

        console.log('secret key ', SECRET_KEY);
        //generate token

        const token =   sign({email: result.email, id: result._id}, SECRET_KEY);
    
        return res.status(200).json({
            token: token,
            data: result
        })

    }catch(error){
        console.error(`error on signIn ${error}`);
        res.status(500).json({message: "Internal server error"});

    }
}

function validateSignin(requestBody){
    const {email,password} = requestBody;
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    const isValidEmail = emailRegex.test(email);

    if((!email) || email == ""){
        return {valid : false, message: 'email should not be empty'};
    }else if(!isValidEmail){
        return {valid : false, message: 'use valid email'};
    }else if((!password) || password == ""){
        return {valid : false, message : 'password should not be empty'};
    }

    return {valid: true};
}


export default {signup, signin};
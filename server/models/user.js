const mongoose = require('mongoose');


const userSchema = new mongoose.Schema({ 
    username:{type:String,required:true},
    email:{type:String,required:true,unique:true},
    uid:{type:String,required:true,unique:true},
    phone:String,


},
{versionKey:false}
);

module.exports = mongoose.model('User', userSchema);
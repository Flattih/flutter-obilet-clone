const mongoose = require('mongoose');

const agencySchema = new mongoose.Schema({ 
    name:String,
    logo:String,
    expeditions:[
        {
            type:mongoose.Schema.Types.ObjectId,
            ref:'Expedition',
        }
    ],
 },
 {versionKey:false});
module.exports = mongoose.model('Agency', agencySchema);
const mongoose = require('mongoose');

function generateSeatNumbers(){
    const seatNumbers = [];
    for(let i=0;i<=40;i++){
        seatNumbers.push({ 
            number: i,
            gender: 'empty',
            isAvailable: true,
            userId: null,
         });
    }
    return seatNumbers;
}

const expeditionSchema =new mongoose.Schema({
    busSeatNumbers:{type:[{
        number:Number,
        gender:String,
        isAvailable:Boolean,
        userId:{
            type:String,
            ref:'User',
        },
    },],
    default:generateSeatNumbers,
},
    estimatedArrival:String,
    departureTime:Date,
    departurePlace:String,
    destinationPlace:String,
    price:String,
    agency:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Agency',
    },
},
{versionKey:false}
);

module.exports = mongoose.model('Expedition', expeditionSchema);

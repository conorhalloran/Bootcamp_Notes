// function SubstitutionCipher (str1, str2) {
//     this.str1 = str1;
//     this.str2 = str2;
// }

// Object.assign(
//     SubstitutionCipher.prototype, 
//     {
        // encode (str) {
        //     strArray = [];
        //     for ( let i = 0; i < str.length; i++ ) {
        //         strArray.push( this.str2[ this.str1.indexOf( str[i] ) ] );
        //     }
        //     return strArray.join("");
//         },
//         decode (str) {
//             strArray = [];
//             for ( let i = 0; i < str.length; i++ ) {
//                 strArray.push( this.str1[ this.str2.indexOf( str[i] ) ] );
//             }
//             return strArray.join("");
//         },
//         } );


class SubstitutionCipher {
    constructor (str1, str2) {
    this.str1 = str1;
    this.str2 = str2;
    }
    encode (str) {
        strArray = [];
        for ( let i = 0; i < str.length; i++ ) {
            strArray.push( this.str2[ this.str1.indexOf( str[i] ) ] );
        }
        return strArray.join("");
    }
    decode (str) {
        strArray = [];
        for ( let i = 0; i < str.length; i++ ) {
            strArray.push( this.str1[ this.str2.indexOf( str[i] ) ] );
        }
        return strArray.join("");
    }
}
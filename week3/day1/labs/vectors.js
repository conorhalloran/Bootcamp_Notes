/* Vectors are a representation of movement in space. That is 2 to 3 distances in x, y and/or z axes. Vectors are very useful when working with graphics, videos and any applications that requires drawing in space.

The figure below shows an example of a Vector.

The grey lines ax, ay and az represent the movement distance respectively in the axes x, y and z.
The black line a represents the length and total movement of ax, ay and az added together.
Our Vector constructor should store values for ax, ay and az. However, I would suggest that you simply use the names, x, y & z, instead. */

/* Your task is to build a Vector constructor.

It should support the coordinates: x, y and z.
It should have 3 prototype methods: plus, minus, magnitude.
The methods, plus & minus, should return a new Vector (not a plain object or an existing vector) with the correct distances.
Create a constructor/prototype version and class based version. */

/*

function Vector (x,y,z) {
    this.x = x;
    this.y = y;
    this.z = z;

}

Object.assign(
    Vector.prototype, 
    {
        plus (Vector2) {
            return new Vector(this.x + Vector2.x, this.y + Vector2.y, this.z + Vector2.z);
        },
        minus (Vector2) {
            return new Vector(this.x - Vector2.x, this.y - Vector2.y, this.z - Vector2.z);
        },
        magnitude () {
            return (this.x*this.x + this.y*this.y + this.z*this.z) **0.5;
        }
    } );

    */

class VectorClass {
    constructor (x,y,z) {
    this.x = x;
    this.y = y;
    this.z = z;
    }
    plus (vector) {
        return new Vector(this.x + vector.x, this.y + vector.y, this.z + vector.z);
    }
    minus (vector) {
        return new Vector(this.x - vector.x, this.y - vector.y, this.z - vector.z);
    }
    magnitude () {
    return (this.x*this.x + this.y*this.y + this.z*this.z) **0.5;
    }
} 
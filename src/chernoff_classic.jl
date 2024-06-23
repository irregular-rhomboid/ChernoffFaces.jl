

"""
Description from the OG paper:

A cartoon face is constructed using 18 variables x[1], ..., x[18] in appropriate ranges. The shape consists of two ellipses with horizontal and vertical major axes which are constructed as follows.

Through a center point O, a ray is drawn to a corner point P. The other corner point P' is taken so that OP and OP' are symmetric with respect to the vertical axis through O.

The points U and L, representing the top and bottom of the face, are such that OU and OL are vertical and have equal length. The top of the face is the ellipse determined by U, P, P' and an eccentricity. The bottom of the face is the ellipse determined by L, P, P' and an eccentricity.

The nose is a line segment centered about O.

The mouth is an arc of a circle

The eyes and eyebrows are ellipses and line segments located symmetrically with respect to the vertical line through O

The pupils are both located the same horizontal distance from the center of the eyes

A normalization is then introduced to make both the width and the length of the face equal to two inches

Ordinarily, an observation Z is normalized linearly so that the corresponding parameter x = a + bZ covers a specified range. Except for the three eccentricities and the curvature of the mouth, these ranges are restricted to subsets of [0,1]. However the eyebrow will tend to cut the eye if x[16] is less than 0.2

- x[1]: radius to corner of face, |OP|;
- x[2]: angle of OP to horizontal
- x[3]: vertical size of face, |OU|
- x[4]: eccentricity of upper face
- x[5]: eccentricity of lower face
- x[6]: length of nose
- x[7]: vertical position of mouth
- x[8]: curvature of mouth
- x[9]: width of mouth
- x[10]: vertical position of eyes
- x[11]: separation of eyes
- x[12]: slant of eyes
- x[13]: eccentricity of eyes
- x[14]: size of eyes
- x[15]: position of pupils
- x[16]: vertical position of eyebrows
- x[17]: slant of eyebrows
- x[18]: size of eyebrows
"""

"""
    ChernoffFace{T} <: AbstractChernoff

A type containing the parameters to draw a Chernoff face as in the original paper.

The field `ranges` is meant to contain the desired ranges for the various parameters. See below for their list and default values.

1. radius to corner of face to origin. defaults to (0.3,0.8)
2. angle of corner of face with horizontal axis. defaults to (-0.4,0.4)
3. half vertical size of face. defaults to (0.7,0.9)
4. width/height ratio of upper face. defaults to (1.2,2.0)
5. width/height ration of loxer face. defaults to (1.0,1.6)
6. length of nose. defaults to (0.1,0.5)
7. vertical position of mouth. defaults to (0.2,0.8)
8. curvature of mouth. defaults to (-0.3,0.9)
9. width of mouth. defaults to (0.2,0.8)
10. vertical position of eyes. defaults to (0.1,0.8)
11. horizontal separation of eyes. defaults to (0.3,0.4)
12. slant of eyes (in radians). defaults to (-0.4,0.4)
13. width/height ration of eyes. defaults to (0.6,0.9)
14. size of eyes. defaults to (0.1,0.4)
15. horizontal position of pupils (relative to center of eye). defaults to (-0.1,0.1)
16. vertical position of eyebrows. defaults to (0.2,0.6)
17. slant of eyebrows (in radians). defaults to (-0.4,0.6)
18. size of eyebrows. defaults to (0.4,0.8)

"""
struct ChernoffFace{T} <: AbstractChernoff
    ranges::Vector{Tuple{T,T}}
end

ChernoffFace() = ChernoffFace(default_ranges_chernoff())

cf_ranges(cf::ChernoffFace) = cf.ranges

function default_ranges_chernoff()
    return [
        (0.3,0.8), # radius to face corner
        (-0.4,0.4), # angle to OP with horizontal
        (0.7,0.9), # vertical size of face
        (1.2,2.0), # upper face eccentricity
        (1.0,1.6), # lower face eccentricity
        (0.1,0.5), # nose length
        (0.2,0.8), # mouth y
        (-0.3,0.9), # mouth curvature
        (0.2,0.8), # mouth width
        (0.1,0.8), # eyes y
        (0.3,0.4), # eye separation
        (-0.4,0.4), # eye slant
        (0.6,0.9), # # eye eccentricity
        (0.1,0.4), # eye size
        (-0.1,0.1), # pupil position
        (0.2,0.6), # eyebrow y
        (-0.4,0.6), # eyebrow slant
        (0.4,0.8) # eyebrow size
    ]
end

using GeometryBasics: Point

"""
    solve_ellipse(xₚ, yₚ, yᵤ, e)

Compute the parameters of the ellipse passing through the points (xₚ,yₚ), (-xₚ,yₚ) and (0,yᵤ) with "eccentricity" e = b/a.

yᵤ is assumed to be the highest point of the ellipse. This function returns ellipse parameters a, b, y₀ and θ such that the equation of the ellipse is
(x/a)^2 + (y-y₀)^2/b^2 = 1
and θ is the angular parameter of the point (xₚ,yₚ)
"""
function solve_ellipse(xₚ, yₚ, yᵤ, e)
    y₀ = (yᵤ^2 - yₚ^2 - e*xₚ^2) / (2*(yᵤ - yₚ))
    b = yᵤ - y₀
    a = b/sqrt(e)
    θ = atan((yₚ-y₀)/b, xₚ/a)
    return a, b, y₀, θ
end

"""
    ellipse_arc(x_0, y_0, w, h, θ_1=0.0, θ_2=2π, rot=0.0)

Compute points on an arc of an ellipse.

## Arguments
* `x` the x coordinate of the center of the ellipse
* `y` the y coordinate of the center of the ellipse
* `w` the half length of the ellipse on the x-axis
* `h` the half length of the ellipse on the y-axis
* `θ_1=0.0` the angular coordinate of the beginning of the arc
* `θ_2=2π` the angular coordinate of the end of the arc
* `rot=0.0` optional rotation angle of the ellipse
"""
function ellipse_arc(x, y, w, h, θ_1=0.0, θ_2=2π, rot=0.0)
    pts = Point[(w*cos(t), h*sin(t)) for t in LinRange(θ_1,θ_2,100)]
    pts_rot = rotate.(pts, rot)
    xy = Point(x,y)
    for i in eachindex(pts_rot)
        pts_rot[i] += xy
    end
    return pts_rot
end

function rotate(p, θ)
    s, c = sincos(θ)
    return Point(c*p[1] - s*p[2], s*p[1] + c*p[2])
end

lerp(t,a,b) = a + t*(b-a)
lerp(t,ab) = lerp(t, ab[1], ab[2])

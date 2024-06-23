module ChernoffFacesMakieExt

using Makie
using ChernoffFaces: lerp, ellipse_arc, solve_ellipse

import ChernoffFaces: chernoff, chernoff!

@recipe(Chernoff) do scene
    Theme(
        grid = false,
        ticks = false
    )
end


function Makie.plot!(chernoff::Chernoff{<:Tuple{AbstractVector{<:Real}, AbstractChernoff}})
    ranges = cf_ranges(chernoff[2])

    x = lerp.(chernoff[1], ranges)

    chernoff_face_makie!(chernoff, x[])
end

function Makie.plot!(chernoff::Chernoff{<:Tuple{AbstractVector{<:Real}}})
    #hidedecorations!(chernoff, grid=false)
    cf = ChernoffFace()
    x = lerp.(chernoff.x[], cf_ranges(cf))

    chernoff_face_makie!(chernoff, x)
end

function chernoff_face_makie!(ax, x)
    y_p, x_p = x[1] .* sincos(x[2])
    y_m = x[3]
    # upper face
    a, b, y_0, θ = solve_ellipse(x_p, y_p, y_m, x[4])
    e_1 = ellipse_arc(0.0, y_0, a, b, θ, π-θ)
    lines!(ax, e_1, color=:black)
    # lower face
    a, b, y_0, θ = solve_ellipse(x_p, -y_p, y_m, x[5])
    e_2 = ellipse_arc(0.0,-y_0, a, b, π+θ, 2π-θ)
    lines!(ax, e_2, color=:black)

    # nose
    lines!(ax, [0.0, 0.0], [-x[6]/2, x[6]/2], color=:black)
    # mouth
    mouth_y = -x[7]*x[3]*0.9
    mouth_r = 1/x[8]
    mouth_angle = atan(x[8]*x[9])
    mouth = ellipse_arc(
        0.0, mouth_y + mouth_r,
        mouth_r,
        mouth_r,
        3π/2 - mouth_angle,
        3π/2 + mouth_angle,
    )
    lines!(ax, mouth, color=:black)
    # eyes
    eyes_y = x[10]*x[3]
    eyes_sep = x[11]*x[3]
    eyes_slant = x[12]
    eyes_size = x[13]*x[3]/2
    eyes_ecc = x[14]
    eye_left = ellipse_arc(
        -(eyes_sep + eyes_size)/2,
        eyes_y,
        eyes_size/2,
        eyes_ecc*eyes_size/2,
         0.0, 2π, -eyes_slant)
    lines!(ax, eye_left, color=:black)
    eye_right = ellipse_arc(
        (eyes_sep+eyes_size)/2,
        eyes_y,
        eyes_size/2,
        eyes_ecc*eyes_size/2,
        0.0, 2π, eyes_slant)
    lines!(ax, eye_right, color=:black)
    #pupils
    pupil_pos = x[15]/2
    pupil_left = ellipse_arc(
        -(eyes_sep+eyes_size)/2 - pupil_pos*eyes_size/2,
        eyes_y,
        0.1*eyes_size,
        0.1*eyes_size)
    poly!(pupil_left, color=:black)
    pupil_right = ellipse_arc(
        (eyes_sep+eyes_size)/2 - pupil_pos*eyes_size/2,
        eyes_y,
        0.1*eyes_size,
        0.1*eyes_size)
    poly!(pupil_right, color=:black)
    # eyebrows
    eyebrow_y = x[16]
    eyebrow_slant = x[17]
    eyebrow_size = x[18]
    lines!(ax,
        [
            -(eyes_sep + eyes_size)/2 - eyes_size*eyebrow_size/2,
            -(eyes_sep + eyes_size)/2 + eyes_size*eyebrow_size/2],
        [
            eyes_y + eyes_ecc*eyes_size*(eyebrow_y + eyebrow_slant) + 0.1,
            eyes_y + eyes_ecc*eyes_size*(eyebrow_y - eyebrow_slant) + 0.1],
        color = :black
    )
    lines!(ax,
        [
            (eyes_sep + eyes_size)/2 + eyes_size*eyebrow_size/2,
            (eyes_sep + eyes_size)/2 - eyes_size*eyebrow_size/2],
        [
            eyes_y + eyes_ecc*eyes_size*(eyebrow_y + eyebrow_slant) + 0.1,
            eyes_y + eyes_ecc*eyes_size*(eyebrow_y - eyebrow_slant) + 0.1],
        color = :black
    )
end

end

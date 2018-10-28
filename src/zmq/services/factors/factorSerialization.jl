using Distributions
using IncrementalInference

import Unmarshal: unmarshal
import Base: convert

"""
Converter: Prior -> JSON-Compliant Prior
"""
function convert(::Type{Dict{String, Any}}, prior::IncrementalInference.Prior)
    # Genericize to any packed type next.
    z =convert(Packed_MvNormal, prior.Z)
    return Packed_PriorPrior(z)
end

"""
Converter: PackedPrior::Dict{String, Any} -> Prior
"""
function convert(::Type{Prior}, prior::Dict{String, Any})
    # Genericize to any packed type next.
    z = prior["measurement"][1]
    z = convert(_evalType(z["distType"]), z)
    return Prior(z)
end

"""
Converter: PackedPrior::Dict{String, Any} -> PriorPose2
"""
function convert(::Type{PriorPose2}, prior::Dict{String, Any})
    # Genericize to any packed type next.
    z = prior["measurement"][1]
    z = convert(_evalType(z["distType"]), z)
    return Prior(z)
end

"""
Converter: PackedPrior::Dict{String, Any} -> PriorPose3
"""
function convert(::Type{PriorPose3}, prior::Dict{String, Any})
    # Genericize to any packed type next.
    z = prior["measurement"][1]
    z = convert(_evalType(z["distType"]), z)
    return Prior(z)
end

"""
Converter: Pose2Pose2::Dict{String, Any} -> Pose2Pose2
"""
function convert(::Type{Pose2Pose2}, prior::Dict{String, Any})
    # Genericize to any packed type next.
    z = prior["measurement"][1]
    z = convert(_evalType(z["distType"]), z)
    return Pose2Pose2(z)
end

"""
Converter: Pose2Point2BearingRange::Dict{String, Any} -> Pose2Point2BearingRange
"""
function convert(::Type{Pose2Point2BearingRange}, fact::Dict{String, Any})
    # Genericize to any packed type next.
    b = fact["measurement"][1]
    r = fact["measurement"][2]
    b = convert(_evalType(b["distType"]), b)
    r = convert(_evalType(r["distType"]), r)
    return Pose2Point2BearingRange(b, r)
end

# TODO: Write the other side of the converters for above before moving.

# In Sonar.jl
# Point3:
#  *✓ Point3Point3
#
# Pose3:
#  *✓ Prior
#  *✓ PartialRollPitchZ (or PartialZ + PartialRP)
#
# Pose3Pose3:
#  *✓ PartialXYYaw
#
# Pose3Pose3Pose3:
#  * Offset
#
# Pose3Point3:
#  * RAE
module DiffEqSensitivity

using DiffEqBase, ForwardDiff, Tracker, FiniteDiff, Statistics
using DiffEqCallbacks, QuadGK, RecursiveArrayTools, LinearAlgebra
using DiffEqOperators
using Adapt
using LinearSolve
using Parameters: @unpack
using StochasticDiffEq
using SharedArrays
using EllipsisNotation
import DiffEqNoiseProcess
import RandomNumbers: Xorshifts
using Random
import ZygoteRules, Zygote, ReverseDiff
import ArrayInterfaceCore, ArrayInterfaceTracker
import Enzyme
import GPUArrays

using Cassette, DiffRules
using Core: CodeInfo, SlotNumber, SSAValue, ReturnNode, GotoIfNot

using Markdown

using Reexport
import ChainRulesCore: @thunk, NoTangent, @not_implemented
@reexport using GlobalSensitivity
abstract type SensitivityFunction end
abstract type TransformedFunction end

include("hasbranching.jl")
include("sensitivity_algorithms.jl")
include("derivative_wrappers.jl")
include("sensitivity_interface.jl")
include("forward_sensitivity.jl")
include("adjoint_common.jl")
include("lss.jl")
include("nilss.jl")
include("nilsas.jl")
include("backsolve_adjoint.jl")
include("interpolating_adjoint.jl")
include("quadrature_adjoint.jl")
include("callback_tracking.jl")
include("concrete_solve.jl")
include("second_order.jl")
include("steadystate_adjoint.jl")
include("sde_tools.jl")

# AD Extensions
include("reversediff.jl")
include("tracker.jl")
include("zygote.jl")


export extract_local_sensitivities


export ODEForwardSensitivityFunction, ODEForwardSensitivityProblem, SensitivityFunction,
       ODEAdjointSensitivityProblem, ODEAdjointProblem, AdjointSensitivityIntegrand,
       SDEAdjointProblem, RODEAdjointProblem, SensitivityAlg,
       adjoint_sensitivities, adjoint_sensitivities_u0,
       ForwardLSSProblem, AdjointLSSProblem,
       NILSSProblem, NILSASProblem,
       shadow_forward, shadow_adjoint

export BacksolveAdjoint, QuadratureAdjoint, InterpolatingAdjoint,
       TrackerAdjoint, ZygoteAdjoint, ReverseDiffAdjoint,
       ForwardSensitivity, ForwardDiffSensitivity,
       ForwardDiffOverAdjoint,
       SteadyStateAdjoint,
       ForwardLSS, AdjointLSS, NILSS, NILSAS

export second_order_sensitivities, second_order_sensitivity_product

export TrackerVJP, ZygoteVJP, EnzymeVJP, ReverseDiffVJP

export StochasticTransformedFunction

function gsa(f, method::GlobalSensitivity.GSAMethod, args...; kwargs...)
    @warn "Global Sensitivity Analysis has been moved to separate package GlobalSensitivity.jl (https://github.com/SciML/GlobalSensitivity.jl)"
    GlobalSensitivity.gsa(f, method, args...; kwargs...)
end
end # module

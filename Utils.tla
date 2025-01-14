-------------------------------- MODULE Utils -------------------------------
(************************************************************************************)
(* This module has general utilities most of them are from the community modules.   *)
(*                                                                                  *)
(* https://github.com/tlaplus/CommunityModules/blob/master/modules/SequencesExt.tla *)
(************************************************************************************)
LOCAL INSTANCE Sequences
LOCAL INSTANCE Naturals
LOCAL INSTANCE FiniteSets

\* Given a set of numbers, returns the maximum number.
Max(S) == CHOOSE x \in S : \A y \in S : x >= y

-----------------------------------------------------------------------------

(***************************************************************************)
(* A function is injective iff it maps each element in its domain to a     *)
(* distinct element.                                                       *)
(*                                                                         *)
(* This definition is overridden by TLC in the Java class Functions.java   *)
(* The operator is overridden by the Java method with the same name.       *)
(***************************************************************************)
IsInjective(f) == \A a,b \in DOMAIN f : f[a] = f[b] => a = b

ToSet(s) ==
  (*************************************************************************)
  (* The image of the given sequence s. Cardinality(ToSet(s)) <= Len(s)    *)
  (* see https://en.wikipedia.org/wiki/Image_(mathematics)                 *)
  (*************************************************************************)
  { s[i] : i \in DOMAIN s }

SetToSeq(S) == 
(**************************************************************************)
(* Convert a set to some sequence that contains all the elements of the   *)
(* set exactly once, and contains no other elements.                      *)
(**************************************************************************)
CHOOSE f \in [1..Cardinality(S) -> S] : IsInjective(f)

Reverse(s) ==
  (**************************************************************************)
  (* Reverse the given sequence s:  Let l be Len(s) (length of s).          *)
  (* Equals a sequence s.t. << S[l], S[l-1], ..., S[1]>>                    *)
  (**************************************************************************)
  [ i \in 1..Len(s) |-> s[(Len(s) - i) + 1] ]

Remove(s, e) ==
    (************************************************************************)
    (* The sequence s with e removed or s iff e \notin Range(s)             *)
    (************************************************************************)
    SelectSeq(s, LAMBDA t: t # e)

=============================================================================

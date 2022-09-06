Require Import Category.Lib.
Require Import Category.Theory.Category.
Require Import Category.Theory.Functor.
Require Import Category.Theory.Monad.
Require Import Category.Structure.Monoidal.
Require Import Category.Functor.Structure.Monoidal.
Require Import Category.Functor.Structure.Monoidal.Pure.
Require Import Category.Functor.Strong.

Generalizable All Variables.

Section MonadDistributive.

Context {C : Category}.
Context `{@Monoidal C}.

Context {M : C ⟶ C}.
Context {O : @Monad C M}.

Context {N : C ⟶ C}.
Context `{@StrongFunctor C _ N}.
Context `{@LaxMonoidalFunctor C C _ _ N}.

Class Monad_Distributive := {
  prod {A} : N (M (N A)) ~> M (N A);

  prod_fmap_fmap {A B} (f : A ~> B) :
    @prod B ∘ fmap[N] (fmap[M ◯ N] f) ≈ fmap[M ◯ N] f ∘ @prod A;
  prod_pure {A} : @prod A ∘ pure[N] ≈ id;
  prod_fmap_pure {A} : @prod A ∘ fmap[N] (ret[M] ∘ pure[N]) ≈ ret[M];
  prod_fmap_join_fmap_prod {A} :
    @prod A ∘ fmap[N] (join[M] ∘ fmap[M] (@prod A))
      ≈ join[M] ∘ fmap[M] (@prod A) ∘ @prod (M (N A))
}.

End MonadDistributive.

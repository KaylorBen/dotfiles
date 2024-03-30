self: super:
{
  fflogs =
    super.callPackage ./packages/fflogs { };

  wowup =
    super.callPackage ./packages/wowup { };
}

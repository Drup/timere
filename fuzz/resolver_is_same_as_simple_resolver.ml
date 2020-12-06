open Fuzz_utils

let search_start_dt =
  Result.get_ok
  @@ Time.Date_time.make ~year:2000 ~month:`Jan ~day:1 ~hour:0 ~minute:0
    ~second:0 ~tz_offset_s:0

let search_start = Time.Date_time.to_timestamp search_start_dt

let search_end_exc_dt =
  Result.get_ok
  @@ Time.Date_time.make ~year:2003 ~month:`Jan ~day:1 ~hour:0 ~minute:0
    ~second:0 ~tz_offset_s:0

let search_end_exc = Time.Date_time.to_timestamp search_end_exc_dt

let () =
  Crowbar.add_test ~name:"resolver_is_same_as_simple_resolver" [ time ]
    (fun t ->
       Crowbar.check_eq ~eq:(OSeq.equal ~eq:( = ))
         (Result.get_ok
          @@ Resolver.resolve
            Time.(
              inter [ t; interval_dt_exc search_start_dt search_end_exc_dt ]))
         (Simple_resolver.resolve ~search_start ~search_end_exc
            ~search_using_tz_offset_s:0 t))

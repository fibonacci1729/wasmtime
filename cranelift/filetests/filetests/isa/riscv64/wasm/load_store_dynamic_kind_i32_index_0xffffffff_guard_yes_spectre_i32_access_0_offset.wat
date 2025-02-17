;;! target = "riscv64"
;;!
;;! settings = ['enable_heap_access_spectre_mitigation=true']
;;!
;;! compile = true
;;!
;;! [globals.vmctx]
;;! type = "i64"
;;! vmctx = true
;;!
;;! [globals.heap_base]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 0, readonly = true }
;;!
;;! [globals.heap_bound]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 8, readonly = true }
;;!
;;! [[heaps]]
;;! base = "heap_base"
;;! min_size = 0x10000
;;! offset_guard_size = 0xffffffff
;;! index_type = "i32"
;;! style = { kind = "dynamic", bound = "heap_bound" }

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store offset=0)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load offset=0))

;; function u0:0:
;; block0:
;;   slli t3,a0,32
;;   srli t0,t3,32
;;   ld t4,8(a2)
;;   addi t4,t4,-4
;;   ld t1,0(a2)
;;   add t1,t1,t0
;;   ugt t3,t0,t4##ty=i64
;;   li t0,0
;;   selectif_spectre_guard t4,t0,t1##test=t3
;;   sw a1,0(t4)
;;   j label1
;; block1:
;;   ret
;;
;; function u0:1:
;; block0:
;;   slli t3,a0,32
;;   srli t0,t3,32
;;   ld t4,8(a1)
;;   addi t4,t4,-4
;;   ld t1,0(a1)
;;   add t1,t1,t0
;;   ugt t3,t0,t4##ty=i64
;;   li t0,0
;;   selectif_spectre_guard t4,t0,t1##test=t3
;;   lw a0,0(t4)
;;   j label1
;; block1:
;;   ret

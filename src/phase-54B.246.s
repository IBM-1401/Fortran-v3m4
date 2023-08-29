               JOB  Fortran compiler -- Limited I/O -- Phase 54B
               CTL  6611
     *
     * Limited I/O routine -- no formatting
     * Completely revised in v3m4
     *
     x1        equ  89
     x2        equ  94
     x3        equ  99
     *
     * Address in format loader
     *
     lret      equ  1030  return here from limited load
     *
               ORG  1697
 1697          SBR  x1
 1701          SW   gmwm
 1705          LCA  x3,39
 1712          LCA
 1713          MN   0&X1,wt&3
 1720          BWZ  *&8,0&X1,S
 1728          MCW  kr,wt&7
 1735          SBR  exit&3,7&X1
 1742          MCW  6&X1,x1
 1749loop      BCE  done,0&X1,.
 1757          MCW  3&X1,x2
 1764          MCW  6&X1,x3
 1771          SBR  x1,7&X1
 1778          MCW  1&X3,w1
 1785          LCA  gmwm,1&X3
 1792          SBR  wt&6,1&X2
 1799retry     S    errcnt
 1803retryw    S    erwcnt
 1807wt        WTW  1,0-0
 1815          BCE  erwtst,wt&7,W  go test for write error
 1823          BEF  eofr        end file on read?
 1828          BCE  wt,14&X2,}  Noise (short) record?
 1836          chain12
 1848          BER  taperr      error on read?
 1853          B    cont
     *
     * EOF while reading
     *
 1857eofr      NOP  888
 1861          H
     *
 1862cont      MCW  w1,1&X3
 1869          B    loop
     *
     * Error while reading, or after three retries on writing
     *
 1873taperr    MN   wt&3,*&4
 1880          BSP  0
 1885          BCE  errhlt,errcnt,I
 1893          A    *-6,errcnt
 1900          BCE  wt,wt&7,R
 1908          MN   wt&3,*&4
 1915          SKP  0-0
 1920          B    retryw
     *
     * Test for error or EOF on write
     *
 1924erwtst    BER  taperw  error on write?
 1929          BEF  eofw    eof on write?
 1934          B    cont
     *
     * Error while writing
     *
 1938taperw    BCE  taperr,erwcnt,C
 1946          MN   wt&3,*&4
 1953          BSP  0-0
 1958          A    *-6,erwcnt
 1965          B    wt
     *
     * EOF while writing
 1969eofw      NOP  666
 1973          H
 1974          B    cont
     *
     * Tape error
     *
 1978errhlt    NOP  777
 1982          H
 1983          B    retry
     *
 1987done      MCW  39,x3
 1994          MCW
 1995          MCW  kw,wt&7
 2002exit      B    0
     *
     * Data
     *
 2006kr        DCW  @R@
 2007w1        DCW  #1
 2008errcnt    DCW  #1
 2009erwcnt    DCW  #1
 2010kw        DCW  @W@
 2011gmwm      DCW  @}@
               ex   lret  Return to format loader after loading
               END

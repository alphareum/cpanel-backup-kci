(()=>{var e={};e.id=981,e.ids=[981],e.modules={7849:e=>{"use strict";e.exports=require("next/dist/client/components/action-async-storage.external")},2934:e=>{"use strict";e.exports=require("next/dist/client/components/action-async-storage.external.js")},5403:e=>{"use strict";e.exports=require("next/dist/client/components/request-async-storage.external")},4580:e=>{"use strict";e.exports=require("next/dist/client/components/request-async-storage.external.js")},4749:e=>{"use strict";e.exports=require("next/dist/client/components/static-generation-async-storage.external")},5869:e=>{"use strict";e.exports=require("next/dist/client/components/static-generation-async-storage.external.js")},399:e=>{"use strict";e.exports=require("next/dist/compiled/next-server/app-page.runtime.prod.js")},4808:(e,a,r)=>{"use strict";r.r(a),r.d(a,{GlobalError:()=>s.a,__next_app__:()=>h,originalPathname:()=>u,pages:()=>d,routeModule:()=>m,tree:()=>c}),r(6139),r(4625),r(7824),r(3358);var n=r(3282),t=r(5736),i=r(3906),s=r.n(i),l=r(6880),o={};for(let e in l)0>["default","tree","pages","GlobalError","originalPathname","__next_app__","routeModule"].indexOf(e)&&(o[e]=()=>l[e]);r.d(a,o);let c=["",{children:["(public)",{children:["blog",{children:["__PAGE__",{},{page:[()=>Promise.resolve().then(r.bind(r,6139)),"C:\\Users\\alpha\\OneDrive\\Documents\\GitHub\\website-kci\\apps\\web\\app\\(public)\\blog\\page.js"]}]},{}]},{layout:[()=>Promise.resolve().then(r.bind(r,4625)),"C:\\Users\\alpha\\OneDrive\\Documents\\GitHub\\website-kci\\apps\\web\\app\\(public)\\layout.js"],"not-found":[()=>Promise.resolve().then(r.t.bind(r,7824,23)),"next/dist/client/components/not-found-error"]}]},{layout:[()=>Promise.resolve().then(r.bind(r,3358)),"C:\\Users\\alpha\\OneDrive\\Documents\\GitHub\\website-kci\\apps\\web\\app\\layout.js"],"not-found":[()=>Promise.resolve().then(r.t.bind(r,7824,23)),"next/dist/client/components/not-found-error"]}],d=["C:\\Users\\alpha\\OneDrive\\Documents\\GitHub\\website-kci\\apps\\web\\app\\(public)\\blog\\page.js"],u="/(public)/blog/page",h={require:r,loadChunk:()=>Promise.resolve()},m=new n.AppPageRouteModule({definition:{kind:t.x.APP_PAGE,page:"/(public)/blog/page",pathname:"/blog",bundlePath:"",filename:"",appPaths:[]},userland:{loaderTree:c}})},4974:(e,a,r)=>{Promise.resolve().then(r.bind(r,6682))},8265:()=>{},8412:()=>{},4090:(e,a,r)=>{Promise.resolve().then(r.t.bind(r,4424,23)),Promise.resolve().then(r.t.bind(r,7752,23)),Promise.resolve().then(r.t.bind(r,5275,23)),Promise.resolve().then(r.t.bind(r,9842,23)),Promise.resolve().then(r.t.bind(r,1633,23)),Promise.resolve().then(r.t.bind(r,9224,23))},6682:(e,a,r)=>{"use strict";r.d(a,{BlogPageClient:()=>d});var n=r(3227),t=r(649),i=r(3083),s=r(4664),l=r(4985);let o=[{href:"/#beranda",label:"Beranda"},{href:"/#visi-misi",label:"Visi Misi"},{href:"/tentang_kci",label:"Tentang"},{href:"/#acara",label:"Acara"},{href:"/galeri",label:"Galeri"},{href:"/blog",label:"Blog"},{href:"/#testimoni",label:"Testimoni"},{href:"/#kontak",label:"Kontak"},{href:"/#sponsor",label:"Partner"}];function c({post:e}){let a=function(e){if(!e)return null;let a=new Date(e);return Number.isNaN(a.getTime())?null:a.toLocaleDateString("id-ID",{day:"numeric",month:"long",year:"numeric",timeZone:"Asia/Jakarta"})}(e.published_at);return(0,n.jsxs)("article",{className:"blog-card",children:[e.cover_image_url?n.jsx(t.default,{href:`/blog/${e.slug}`,className:"blog-card__image",children:n.jsx("img",{src:e.cover_image_url,alt:e.title,loading:"lazy"})}):null,(0,n.jsxs)("div",{className:"blog-card__content",children:[a?n.jsx("span",{className:"blog-card__date",children:a}):null,n.jsx("h3",{children:n.jsx(t.default,{href:`/blog/${e.slug}`,children:e.title})}),e.summary?n.jsx("p",{children:e.summary}):null,n.jsx(t.default,{className:"blog-card__cta",href:`/blog/${e.slug}`,children:"Baca selengkapnya →"})]})]})}function d(){let{data:e,error:a,isLoading:r}=(0,i.ZP)("/posts",()=>(0,l.R1)("/posts")),t=e?.posts??[];return(0,n.jsxs)(s.LegacyShell,{navLinks:o,variant:"home",children:[n.jsx("style",{children:`
        .blog-hero {
          background: linear-gradient(135deg, rgba(143, 29, 29, 0.92), rgba(192, 46, 46, 0.85)), url('/assets/texture.png');
          color: white;
          padding: 120px 0 80px;
          text-align: center;
        }
        .blog-hero h1 {
          font-size: clamp(2rem, 4vw, 3rem);
          margin-bottom: 1rem;
        }
        .blog-hero p {
          max-width: 640px;
          margin: 0 auto;
          font-size: 1.1rem;
          color: rgba(255, 255, 255, 0.9);
        }
        .blog-grid {
          display: grid;
          gap: 32px;
          grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        }
        .blog-card {
          background: white;
          border-radius: 18px;
          border: 1px solid var(--border-color);
          overflow: hidden;
          box-shadow: var(--shadow);
          display: flex;
          flex-direction: column;
        }
        .blog-card__image {
          display: block;
          width: 100%;
          aspect-ratio: 16 / 9;
          overflow: hidden;
          background: var(--light-gray);
        }
        .blog-card__image img {
          width: 100%;
          height: 100%;
          object-fit: cover;
          display: block;
        }
        .blog-card__content {
          padding: 20px 22px 24px;
          display: flex;
          flex-direction: column;
          gap: 12px;
        }
        .blog-card__content h3 {
          font-size: 1.35rem;
          margin: 0;
        }
        .blog-card__content h3 a {
          text-decoration: none;
          color: inherit;
        }
        .blog-card__content h3 a:hover {
          color: var(--primary-red);
        }
        .blog-card__date {
          font-size: 0.9rem;
          color: var(--gray);
          letter-spacing: 0.02em;
        }
        .blog-card__cta {
          align-self: flex-start;
          color: var(--primary-red);
          font-weight: 600;
          text-decoration: none;
        }
        .blog-card__cta:hover {
          text-decoration: underline;
        }
        .blog-empty {
          text-align: center;
          padding: 80px 0;
          color: var(--gray);
          border-radius: 18px;
          background: rgba(255, 255, 255, 0.75);
          border: 1px dashed var(--border-color);
        }
      `}),n.jsx("section",{className:"blog-hero",children:(0,n.jsxs)("div",{className:"container",children:[n.jsx("h1",{children:"Blog Komunitas Chinese Indonesia"}),n.jsx("p",{children:"Jelajahi cerita, pembaruan, dan wawasan terbaru dari komunitas kami. Temukan kisah inspiratif dan kegiatan terbaru KCI."})]})}),n.jsx("section",{className:"section",style:{paddingTop:"48px"},children:n.jsx("div",{className:"container",style:{color:"var(--gray)",fontSize:"0.95rem"},children:(0,n.jsxs)("span",{children:[n.jsx("a",{className:"nav-link",href:"/",style:{padding:0,fontWeight:600},children:"Beranda"})," ","› Blog"]})})}),n.jsx("section",{className:"section section-alt",style:{paddingTop:"36px"},children:n.jsx("div",{className:"container",children:a?n.jsx("div",{className:"alert",children:a.message}):r?n.jsx("p",{children:"Memuat artikel…"}):0===t.length?n.jsx("div",{className:"blog-empty",children:"Belum ada artikel yang dipublikasikan."}):n.jsx("div",{className:"blog-grid",children:t.map(e=>n.jsx(c,{post:e},e.id))})})}),n.jsx("footer",{children:(0,n.jsxs)("div",{className:"container",children:[(0,n.jsxs)("div",{className:"footer-content",children:[(0,n.jsxs)("div",{className:"footer-section",children:[n.jsx("h3",{children:"Komunitas Chinese Indonesia"}),n.jsx("p",{children:"文化连心，共创未来"})]}),(0,n.jsxs)("div",{className:"footer-section",children:[n.jsx("h3",{children:"Tautan Cepat"}),n.jsx("p",{children:n.jsx("a",{href:"/#visi-misi",children:"Visi & Misi"})}),n.jsx("p",{children:n.jsx("a",{href:"/#acara",children:"Acara"})}),n.jsx("p",{children:n.jsx("a",{href:"/galeri",children:"Galeri"})}),n.jsx("p",{children:n.jsx("a",{href:"/blog",children:"Blog"})}),n.jsx("p",{children:n.jsx("a",{href:"/#kontak",children:"Kontak"})})]}),(0,n.jsxs)("div",{className:"footer-section",children:[n.jsx("h3",{children:"Hubungi Kami"}),n.jsx("p",{children:"Founder: 0878-8492-4385"}),n.jsx("p",{children:"Admin: 0856-4187-7775"}),n.jsx("p",{children:"Instagram: @komunitaschineseindonesia"})]})]}),(0,n.jsxs)("div",{className:"footer-bottom",children:[(0,n.jsxs)("p",{children:["\xa9 ",new Date().getFullYear()," Komunitas Chinese Indonesia. All rights reserved."]}),n.jsx("p",{children:"Unity in Diversity - Bhinneka Tunggal Ika"})]})]})})]})}},4664:(e,a,r)=>{"use strict";r.d(a,{LegacyShell:()=>h,x:()=>c});var n=r(3227),t=r(649),i=r(3677),s=r(3083),l=r(4985);let o=Object.freeze({primary:[],secondary:[],social:[]});function c(){let{data:e,error:a,isLoading:r}=(0,s.ZP)("/links",()=>(0,l.R1)("/links"));return{groups:(0,i.useMemo)(()=>e?.links?function(e){if(!Array.isArray(e))return o;let a={primary:[],secondary:[],social:[]};return e.forEach(e=>{if(!e?.is_active)return;let r=e?.category;if(!r||!(r in a))return;let n=function(e){let a=e?.url??e?.href??"",r=e?.label??e?.title??e?.name??a;return{id:e?.id,label:r,href:a,url:a,icon:"string"==typeof e?.icon&&e.icon?e.icon:void 0,original:e}}(e);n.href&&n.label&&a[r].push(n)}),a}(e.links):o,[e]),error:a,isLoading:r}}function d(e){return e.startsWith("#")}function u({href:e,children:a,onClick:r}){let i="nav-link";return/^https?:/i.test(e)?n.jsx("a",{href:e,className:i,target:"_blank",rel:"noopener noreferrer",onClick:r,children:a}):d(e)?n.jsx("a",{href:e,className:i,onClick:r,children:a}):n.jsx(t.default,{href:e,className:i,onClick:r,children:a})}function h({children:e,navLinks:a=[],variant:r="home"}){let[t,s]=(0,i.useState)(!1),[l,o]=(0,i.useState)("light"),[c,h]=(0,i.useState)(!1),[m,p]=(0,i.useState)("translateY(0)"),[g,x]=(0,i.useState)(!0);(0,i.useRef)(0);let b=(0,i.useRef)(null),f=e=>a=>{if(d(e)){a.preventDefault();let r=document.querySelector(e);if(r){let e=r.getBoundingClientRect().top+window.scrollY-100;window.scrollTo({top:e,behavior:"smooth"})}}s(!1)},j=(0,i.useMemo)(()=>"dark"===l?"\uD83C\uDF19":"☀️",[l]),v=`legacy-shell${t?" legacy-shell--menu-open":""}`,y=(0,i.useMemo)(()=>Array.isArray(a)?a.filter(e=>e?.href&&e?.label):[],[a]);return(0,n.jsxs)("div",{className:v,"data-theme":l,children:[n.jsx("div",{className:"pattern-overlay","aria-hidden":"true"}),n.jsx("div",{className:`loader${g?"":" hidden"}`,id:"loader","aria-hidden":g?"false":"true",children:n.jsx("div",{className:"loader-spinner"})}),n.jsx("header",{id:"header",ref:b,style:{transform:m},children:(0,n.jsxs)("nav",{className:"container nav-container",children:[n.jsx("div",{className:"logo-section",children:(0,n.jsxs)("div",{className:"logo-text",children:[n.jsx("span",{className:"logo-main",children:"KCI"}),n.jsx("span",{className:"logo-sub",children:"Komunitas Chinese Indonesia"})]})}),(0,n.jsxs)("ul",{className:`nav-menu${t?" active":""}`,id:"navMenu",children:[y.map(e=>n.jsx("li",{children:n.jsx(u,{href:e.href,onClick:f(e.href),children:e.label})},e.href)),n.jsx("li",{children:n.jsx("button",{type:"button",className:"theme-toggle",id:"themeToggle",onClick:()=>{o(e=>"dark"===e?"light":"dark")},"aria-label":"Toggle tema",children:j})})]}),(0,n.jsxs)("button",{type:"button",className:`menu-toggle${t?" active":""}`,id:"menuToggle","aria-expanded":t,"aria-label":"Toggle navigasi",onClick:()=>s(e=>!e),children:[n.jsx("span",{}),n.jsx("span",{}),n.jsx("span",{})]})]})}),n.jsx("div",{className:`legacy-content legacy-content--${r}`,children:e}),n.jsx("button",{type:"button",className:`scroll-top${c?" visible":""}`,id:"scrollTop",onClick:()=>{window.scrollTo({top:0,behavior:"smooth"})},"aria-label":"Kembali ke atas",children:"↑"})]})}},4985:(e,a,r)=>{"use strict";async function n(e,a={}){let r=`https://api.komunitaschineseindonesia.com${e}`,n="undefined"!=typeof FormData&&a.body instanceof FormData?{...a.headers||{}}:{"Content-Type":"application/json",...a.headers||{}},t=await fetch(r,{...a,headers:n});if(!t.ok){let e=t.statusText;try{let a=await t.json();e=a?.message||e}catch(e){}throw Error(e||"Request failed")}return 204===t.status?null:await t.json()}function t(e){return n(e,{method:"GET"})}function i(e,a){return n(e,{method:"POST",body:JSON.stringify(a)})}function s(e,a){return n(e,{method:"POST",body:a})}function l(e){return n(e,{method:"DELETE"})}r.d(a,{QW:()=>l,R1:()=>t,sg:()=>i,zi:()=>s})},6139:(e,a,r)=>{"use strict";r.r(a),r.d(a,{default:()=>d,metadata:()=>c});var n=r(9013),t=r(3189);let i=(0,t.createProxy)(String.raw`C:\Users\alpha\OneDrive\Documents\GitHub\website-kci\apps\web\app\(public)\blog\BlogPageClient.js`),{__esModule:s,$$typeof:l}=i;i.default;let o=(0,t.createProxy)(String.raw`C:\Users\alpha\OneDrive\Documents\GitHub\website-kci\apps\web\app\(public)\blog\BlogPageClient.js#BlogPageClient`),c={title:"Blog — Komunitas Chinese Indonesia",description:"Artikel terbaru, cerita komunitas, dan pembaruan Komunitas Chinese Indonesia (KCI)."};function d(){return n.jsx(o,{})}},4625:(e,a,r)=>{"use strict";r.r(a),r.d(a,{default:()=>t});var n=r(9013);function t({children:e}){return n.jsx(n.Fragment,{children:e})}r(5643)},3358:(e,a,r)=>{"use strict";r.r(a),r.d(a,{default:()=>i,metadata:()=>t});var n=r(9013);r(1);let t={title:{default:"Komunitas Chinese Indonesia",template:"%s — Komunitas Chinese Indonesia"},description:"Komunitas Chinese Indonesia (KCI) menjadi ruang kolaborasi untuk melestarikan budaya dan menggerakkan komunitas."};function i({children:e}){return n.jsx("html",{lang:"id",children:n.jsx("body",{children:e})})}},5643:()=>{},1:()=>{}};var a=require("../../../webpack-runtime.js");a.C(e);var r=e=>a(a.s=e),n=a.X(0,[592,649,83],()=>r(4808));module.exports=n})();
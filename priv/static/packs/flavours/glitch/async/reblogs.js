(window.webpackJsonp=window.webpackJsonp||[]).push([[74],{660:function(t,a,s){"use strict";s.r(a),s.d(a,"default",function(){return g});var o,e,n,c=s(0),r=s(3),i=s(7),p=s(1),u=(s(2),s(24)),d=s(5),l=s.n(d),b=s(27),h=s.n(b),O=s(271),j=s(49),f=s(426),m=s(600),v=s(624),I=s(929),w=s(25),g=Object(u.connect)(function(t,a){return{accountIds:t.getIn(["user_lists","reblogged_by",a.params.statusId])}})((n=e=function(e){function t(){for(var t,a=arguments.length,s=new Array(a),o=0;o<a;o++)s[o]=arguments[o];return t=e.call.apply(e,[this].concat(s))||this,Object(p.a)(Object(r.a)(t),"shouldUpdateScroll",function(t,a){var s=a.location;return!(((t||{}).location||{}).state||{}).mastodonModalOpen&&!(s.state&&s.state.mastodonModalOpen)}),t}Object(i.a)(t,e);var a=t.prototype;return a.componentWillMount=function(){this.props.dispatch(Object(j.r)(this.props.params.statusId))},a.componentWillReceiveProps=function(t){t.params.statusId!==this.props.params.statusId&&t.params.statusId&&this.props.dispatch(Object(j.r)(t.params.statusId))},a.render=function(){var t=this.props.accountIds;return t?Object(c.a)(v.a,{},void 0,Object(c.a)(I.a,{}),Object(c.a)(f.a,{scrollKey:"reblogs",shouldUpdateScroll:this.shouldUpdateScroll},void 0,Object(c.a)("div",{className:"scrollable reblogs"},void 0,t.map(function(t){return Object(c.a)(m.a,{id:t,withNote:!1},t)})))):Object(c.a)(v.a,{},void 0,Object(c.a)(O.a,{}))},t}(w.a),Object(p.a)(e,"propTypes",{params:l.a.object.isRequired,dispatch:l.a.func.isRequired,accountIds:h.a.list}),o=n))||o}}]);
//# sourceMappingURL=reblogs.js.map